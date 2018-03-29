//
//  SplashViewController.swift
//  Vault_iOS
//
//  Created by Lusine Sargsyan on 2/22/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

final class SplashViewController: BackgroundImagedViewController<SplashViewModel> {

    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        progressView.progress = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadProgress()
    }

    func loadProgress() {
        if let viewModel = viewModel {
            UIView.animate(withDuration: viewModel.progressSeconds) {
                self.progressView.setProgress(1.0, animated: true)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.progressSeconds) {
                if let viewController = ViewControllerProvider.login {
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
    }
}

