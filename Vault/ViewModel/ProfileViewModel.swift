//
//  ProfileViewModel.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/3/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation
import UIKit

struct ProfileViewModelInputs {
    let downloadManager: DownloadManager
}

final class ProfileViewModel: ViewModel<ProfileViewModelInputs> {
    private var loginInfo: Login?

    private var profilePresenter: ProfilePresenter? {
        didSet {
            guard let successHandler = successHandler,
                let profilePresenter = profilePresenter else { return }

            successHandler(.profile(presenter: profilePresenter))
        }
    }

    func setup(with viewModel: LoginViewModel?) {
        self.loginInfo = viewModel?.loginInfo
    }

    func fetchProfileData() {
        guard let loginInfo = self.loginInfo else { return }

        let displayName = loginInfo.displayName ?? "\(loginInfo.firstName ?? "") \(loginInfo.middleName ?? "") \(loginInfo.lastName ?? "")"
        profilePresenter = ProfilePresenter(name: displayName, email: loginInfo.email ?? "", image: nil, isImageLoading: true)

        if let url = URL(string: loginInfo.photo ?? "") {
            inputs.downloadManager.downloadDataFromUrl(url: url, completion: { [weak self] (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    self?.profilePresenter = ProfilePresenter(name: displayName, email: loginInfo.email ?? "", image: image, isImageLoading: false)
                } else {
                    self?.profilePresenter = ProfilePresenter(name: displayName, email: loginInfo.email ?? "", image: nil, isImageLoading: false)
                }
            })
        }
    }

    func logout() {
        Session.kill()
    }
}
