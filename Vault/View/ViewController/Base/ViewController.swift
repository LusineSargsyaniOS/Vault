//
//  ViewController.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/28/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

class ViewController<Type: ViewModeling>: UIViewController, UIGestureRecognizerDelegate {
    // set true if you want to have action on empty space
    open var shouldReactOnEmptySpaceTap: Bool { return false }

    // Default value is set in setupEmptySpaceActionIfNeeded(), hidding keyboard
    public var emptySpaceTapping: (() -> Void)?

    var viewModel: Type?
    // do not forget to remove from super view in case of success after retry
    let errorView: ErrorView? = ErrorView.loadNib()

    // Set the view which tap will have higher priority than gesture tap (mainly this issue can be with tableViews, cell selection)
    var gestureTapIgnoringView: UIView?

    private lazy var loadingView: LoadingView? = {
        let loadingView: LoadingView? = LoadingView.loadNib()

        loadingView?.translatesAutoresizingMaskIntoConstraints = false

        return loadingView
    }()

    private lazy var bannerView: BannerView? = {
        guard let banner: BannerView = BannerView.loadNib() else { return nil }

        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

        self.view.addSubview(banner)
        self.view.addConstraint(NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: banner, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: banner, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0))

        return banner
    }()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView?.alpha = 0.0

        setupNavigation()
        setupEmptySpaceActionIfNeeded()
        setupLoadingHandling()
        setupErrorHandling()
        setupSuccessHandling()
        setupHiddingOfErrorView()
    }

    // MARK: Open Functions
    open func setupNavigation() {
        edgesForExtendedLayout = []
    }

    // Override and set successHandler in childs
    open func setupSuccessHandling() {}

    // Override and set custom loadingHandler in childs if needed
    open func setupLoadingHandling() {
        viewModel?.loadingHandler = { [weak self] isLoading in
            guard let strongSelf = self else { return }

            if let loadingView = strongSelf.loadingView {
                if isLoading {
                    strongSelf.setupLoadingViewConstraints()
                    loadingView.animate()
                } else {
                    loadingView.stop()
                    loadingView.removeFromSuperview()
                }
            }
        }
    }

    // Override and set custom errorHandler in childs if needed
    open func setupErrorHandling() {
        viewModel?.errorHandler = { [weak self] error in
            guard let strongSelf = self else { return }

            strongSelf.hideErrorViewIfNeeded()

            var errorMessage = ""

            switch error {
            case CustomError.service(let message):
                errorMessage = message
            case CustomError.validation(let message):
                errorMessage = message
            case CustomError.unReachable:
                errorMessage = Text.Global.noConnection
            default:
                errorMessage = error.localizedDescription
            }

            if errorMessage == Text.Global.noConnection {
                strongSelf.handleNoConnection()
            } else {
                strongSelf.handleGenericError(with: errorMessage)
            }
        }
    }

    open func setupHiddingOfErrorView() {
        viewModel?.hiddingErrorHandler = { [weak self] in
            self?.hideErrorViewIfNeeded()
        }
    }

    // ERROR View managment
    open func hideErrorViewIfNeeded() {
        self.errorView?.removeFromSuperview()

        UIView.animate(withDuration: 0.25, animations: {[weak self] in
            self?.bannerView?.alpha = 0.0
        })
    }

    open func handleNoConnection() {
        guard let window = Application.window,
            errorView?.superview == nil else { return }

        errorView?.errorTitle = Text.Error.noConnection
        errorView?.errorMessage = Text.Error.defaultMessage
        errorView?.retryHandler = viewModel?.retryHandler
        errorView?.addInto(superView: window)
    }

    open func handleGenericError(with message: String) {
        bannerView?.state = .error
        bannerView?.bringSubview(toFront: self.view)

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.bannerView?.alpha = 1.0
            self?.bannerView?.message = message
        }
    }

    open func handleGenericSuccess(with message: String, completion: (() -> Void)?) {
        bannerView?.state = .success
        bannerView?.bringSubview(toFront: self.view)

        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.bannerView?.alpha = 1.0
            self?.bannerView?.message = message
        }) { _ in
            UIView.animate(withDuration: 1, delay: 2, options: [], animations: { [weak self] in
                self?.bannerView?.alpha = 0.0
            }, completion: { _ in
                completion?()
            })
        }
    }

    // MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let gestureTapIgnoringView = gestureTapIgnoringView else { return true }

        if touch.view?.isDescendant(of: gestureTapIgnoringView) == true {
            return false
        }

        return true
    }

    // MARK: Private helpers
    private func setupEmptySpaceActionIfNeeded() {
        if shouldReactOnEmptySpaceTap {
            addEmptySpeaceGesture()
        }
    }

    private func setupLoadingViewConstraints() {
        if let window = Application.window,
            let loadingView = loadingView {
            loadingView.addInto(superView: window)
        }
    }

    private func addEmptySpeaceGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emptySpeaceGestureAction))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)

        if emptySpaceTapping == nil {
            emptySpaceTapping = { [weak self] in
                self?.view.endEditing(true)
            }
        }
    }

    @objc private func emptySpeaceGestureAction() {
        emptySpaceTapping?()
    }
}

