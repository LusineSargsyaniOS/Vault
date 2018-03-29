//
//  Device.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/2/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

struct Application {
    static var window: UIWindow? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window
    }
}

struct Device {
    static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad ? true : false
    }
}

struct Text {
    struct Global {
        static let appName      = "Vault"
        static let noConnection = "NoConnection"
    }

    struct URLPaths {
        static let registrationWebPage = "https://v4ul7.io/auth/signup"
        static let baseURL             = "https://v4ul7.io/api"
        static let login               = "/users/auth"
        static let addItem             = "/items"
        static let itemsArticle        = "/items/articles"
        static let itemsCategories     = "/items/categories"
        static let itemsUser           = "/items/user"
        static let updateItem          = "/items/%@"
        static let items               = "/items"
        // If the login url will be changed, change this string value with it to handle it after registration in webview, and show alert about registration succsses
        static let signInRedirection   = "https://v4ul7.io/auth/login"
    }

    struct Params {
        static let email        = "email"
        static let password     = "password"
        static let securityCode = "securityCode"
        static let status       = "status"
        static let category     = "category"
        static let article      = "article"
        static let serialNumber = "serialNumber"
        static let userId       = "userId"
        static let securityPin  = "securityPin"
        static let itemId       = "itemId"
        static let accountId    = "accountId"
    }

    struct Storyboard {
        static let main         = "Main"
        static let splash       = "SplashViewController"
        static let login        = "LoginViewController"
        static let registration = "RegisterViewController"
        static let profile      = "ProfileViewController"
        static let addItem      = "AddItemViewController"
    }

    // should be localized in case of multy language
    struct Common {
        static let ok = "Ok"
    }

    struct Authentication {
        static let email        = "Email"
        static let password     = "Password"
        static let securityCode = "SecurityCode"
        static let login        = "Login"
        static let signup       = "Sign up here!"
    }

    struct Registration {
        static let succeedTitle   = "Registration Succeed"
        static let succeedMessage = "An email regarding further instructions is been sent to you."
    }

    struct UserItems {
        static let title       = "Item list"
        static let emptyResult = "No items to display"
    }

    struct Search {
        static let searchPlaceholder = "Type the Serial Number"
        static let emptyResult       = "No items found"
        static let foundResult       = "Search result"
    }

    struct Profile {
        static let ownedItems = "items owned"
        static let logout     = "Log Out"
        #if DEV
        static let version    = "v.%@ development"
        #endif
    }

    struct AddItem {
        static let successInfo  = "Your request sent to process"
        static let title        = "Add item"
        static let category     = "Category"
        static let article      = "Article"
        static let status       = "Status"
        static let serialNumber = "Serial number..."
        static let about        = "About..."
    }

    struct Error {
        // Common
        static let retry         = "Retry"

        // Login
        static let allEmpty       = "Please provide a valid email and password."
        static let emailEmpty     = "Please provide a valid email."
        static let paswordEmpty   = "Please provide a valid password."

        static let noConnection   = "Oops, your connection seems off..."
        static let defaultMessage = "Keep calm, light a fire and press Retry to try again."
    }

    struct Status {
        static let available = "Available"
        static let lost      = "Lost"
        static let stolen    = "Stolen"
        static let info      = "You can change your item status"
    }
}
