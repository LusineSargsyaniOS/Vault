//
//  MenuViewController.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/3/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

protocol ProfileViewControllered {
    var logoutActionHandler: (() -> Void)? { set get }
    var menuCloseActionHandler: (() -> Void)? { set get }
    var viewController: UIViewController { get }

    func profileOpened()
}

extension ProfileViewControllered where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
}

final class MenuViewController: UIViewController {

    // profileViewController should be set first to be under content
    var profileViewController: ProfileViewControllered? {
        didSet {
            guard var profileViewController = profileViewController else { return }

            self.addChildViewController(profileViewController.viewController)
            profileViewController.viewController.view.addInto(superView: view)
            profileViewController.viewController.didMove(toParentViewController: self)

            profileViewController.logoutActionHandler = { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            profileViewController.menuCloseActionHandler = { [weak self] in
                self?.dragContent()
            }
        }
    }

    var contentViewController: UIViewController? {
        didSet {
            guard let contentViewController = contentViewController else { return }

            if self.childViewControllers.count > 0 {
                let viewControllers: [UIViewController] = self.childViewControllers

                for i in 1..<viewControllers.count {
                    let viewContoller = viewControllers[i]
                    viewContoller.willMove(toParentViewController: nil)
                    viewContoller.view.removeFromSuperview()
                    viewContoller.removeFromParentViewController()
                }
            }

            var navigationController: UINavigationController?

            if let contentViewController = contentViewController as? UINavigationController {
                navigationController = contentViewController
            } else {
                navigationController = contentViewController.navigationController != nil ? contentViewController.navigationController : UINavigationController(rootViewController: contentViewController)
            }

            if let navigationController = navigationController {
                self.addChildViewController(navigationController)
                addConstaints(navigationController.view)
                navigationController.didMove(toParentViewController: self)
            }
        }
    }

    private var contentLeadingConstraint: NSLayoutConstraint?

    private func addConstaints(_ subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subView)
        view.addConstraint(NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        contentLeadingConstraint = NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)

        if let contentLeadingConstraint = self.contentLeadingConstraint {
            view.addConstraint(contentLeadingConstraint)
        }
        
        view.addConstraint(NSLayoutConstraint(item: subView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0, constant: UIScreen.main.bounds.size.width))

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let menu = UIBarButtonItem.button(with: #imageLiteral(resourceName: "ic_menu_white_48px"), target: self, action: #selector(dragContent), size: CGSize(width: 30, height: 30))
        contentViewController?.navigationItem.leftBarButtonItem = menu
    }

    @objc private func dragContent() {
        let isClosed = contentLeadingConstraint?.constant == 0

        self.contentLeadingConstraint?.constant = isClosed ? UIScreen.main.bounds.size.width : 0.0

        if isClosed {
            profileViewController?.profileOpened()
        }

        UIView.animate(withDuration: 0.7) {
            self.view.layoutIfNeeded()
        }
    }
}

