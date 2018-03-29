//
//  AppDelegate.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/25/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = ViewControllerProvider.splash
        self.window?.makeKeyAndVisible()

        setupNavigationBarAppearance()
        #if DEV

        #else
            setupReachibility()
        #endif

        return true
    }

    // MARK: - Private helpers
    private func setupNavigationBarAppearance() {
        UINavigationBar.appearance().barTintColor = Theme.default.colors.navigation
        UINavigationBar.appearance().tintColor = .white

        let size: CGFloat = Device.isPad ? 22 : 16
        if let font = Theme.default.fonts.dejaVuSans(size: size) {
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                                NSAttributedStringKey.font: font]
        }
    }

    private func setupReachibility() {
        do {
            Network.reachability = try Reachability(hostname: Text.URLPaths.baseURL)
            do {
                try Network.reachability?.start()
            } catch let error as Network.Error {
                print(error)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
}
