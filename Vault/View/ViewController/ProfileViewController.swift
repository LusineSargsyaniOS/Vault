//
//  ProfileViewController.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/3/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class ProfileViewController: BackgroundImagedViewController<ProfileViewModel>, ProfileViewControllered {
    var menuCloseActionHandler: (() -> Void)?

    var logoutActionHandler: (() -> Void)?

    @IBOutlet private weak var versionNumber: UILabel! {
        didSet {
            #if DEV
                guard let version =
                    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return }

                versionNumber.text = String(format: Text.Profile.version, version)
            #endif
        }
    }

    @IBOutlet private weak var profilePhotoImageView: UIImageView! {
        didSet {
            profilePhotoImageView.layer.cornerRadius = Device.isPad ? 80 : 42
        }
    }
    @IBOutlet private weak var displayNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var ownedItemsLabel: UILabel!
    @IBOutlet private weak var logoutLabel: UILabel!

    // hidden in stackview from storyboard
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!

    @IBOutlet weak var imageLoadingActivity: UIActivityIndicatorView!

    @IBAction private func closeAction(_ sender: UIButton) {
        menuCloseActionHandler?()
    }
    @IBAction private func logOutAction(_ sender: UIButton) {
        viewModel?.logout()
        logoutActionHandler?()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        logoutLabel.text = Text.Profile.logout

        viewModel?.fetchProfileData()
    }

    func profileOpened() {
        self.ownedItemsLabel.text = "\(Session.ownedItemsCount ?? 0) \(Text.Profile.ownedItems)"
    }

    override open func setupErrorHandling() {}

    override open func setupSuccessHandling() {
        viewModel?.successHandler = { [weak self] responseCase in
            DispatchQueue.main.async {
                guard let strongSelf = self,
                    case let .profile(profilePresenter)? = responseCase else { return }

                strongSelf.displayNameLabel.text = profilePresenter.name
                strongSelf.emailLabel.text = profilePresenter.email
                strongSelf.ownedItemsLabel.text = String(format: Text.Profile.ownedItems, Session.ownedItemsCount ?? 0)
                strongSelf.profilePhotoImageView.image = profilePresenter.image

                profilePresenter.isImageLoading ? strongSelf.imageLoadingActivity.startAnimating() : strongSelf.imageLoadingActivity.stopAnimating()
            }
        }
    }

    override func setupLoadingHandling() {}

    override func setupHiddingOfErrorView() {}
}
