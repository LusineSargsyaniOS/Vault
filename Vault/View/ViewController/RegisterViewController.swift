//
//  RegisterViewController.swift
//  Vault_iOS
//
//  Created by Lusine Sargsyan on 2/23/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

final class RegisterViewController: BackgroundImagedViewController<RegisterViewModel>, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let urlRequest = viewModel?.urlRequest {
            webView.loadRequest(urlRequest)
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        viewModel?.loadingHandler?(false)
        dismiss(animated: true, completion: nil)
    }

    override func setupErrorHandling() {}
    override func setupSuccessHandling() {}

    // MARK: UIWebViewDelegate
    public func webViewDidStartLoad(_ webView: UIWebView) {
        viewModel?.loadingHandler?(true)
    }

    public func webViewDidFinishLoad(_ webView: UIWebView) {
        viewModel?.loadingHandler?(false)
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        viewModel?.loadingHandler?(false)
    }

    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.url?.absoluteString == Text.URLPaths.signInRedirection {
            let alertController = UIAlertController(title: Text.Registration.succeedTitle, message: Text.Registration.succeedMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Text.Common.ok, style: .default, handler: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }))

            self.present(alertController, animated: true, completion: nil)

            return false
        }

        return true
    }
}
