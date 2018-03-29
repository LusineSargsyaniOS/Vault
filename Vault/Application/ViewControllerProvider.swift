//
//  ViewControllerProvider.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/28/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

struct ViewControllerProvider {
    static var splash: SplashViewController? {
        let viewModel = SplashViewModel(inputs: {}())
        let storyboard: UIStoryboard = UIStoryboard(name: Text.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Text.Storyboard.splash) as? SplashViewController

        viewController?.viewModel = viewModel

        return viewController
    }

    static var login: LoginViewController? {
        let loginService = LoginService()
        let inputs = LoginViewModelInputs(loginService: loginService)
        let viewModel = LoginViewModel(inputs: inputs)
        let storyboard: UIStoryboard = UIStoryboard(name: Text.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Text.Storyboard.login) as? LoginViewController

        viewController?.viewModel = viewModel

        return viewController
    }

    static var registration: RegisterViewController? {
        let viewModel = RegisterViewModel(inputs: {}())
        let storyboard: UIStoryboard = UIStoryboard(name: Text.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Text.Storyboard.registration) as? RegisterViewController

        viewController?.viewModel = viewModel

        return viewController
    }

    static var userItems: UserItemsListViewController? {
        let userItemsService = UserItemsService()
        let updateItemService = UpdateItemStatusService()
//        let categoriesItemService = CategoryItemService()
//        let articlesItemService = ArticleItemService()
//        let addItemService = AddItemService()

//        let inputs = UserItemsListViewModelInputs(userItemsService: userItemsService,
//                                                  updateItemService: updateItemService,
//                                                  categoriesService: categoriesItemService,
//                                                  articlesService: articlesItemService,
//                                                  addItemService: addItemService)
        let inputs = UserItemsListViewModelInputs(userItemsService: userItemsService,
                                                  updateItemService: updateItemService)

        let viewModel = UserItemsListViewModel(inputs: inputs)
        let viewController = UserItemsListViewController()

        viewController.viewModel = viewModel

        return viewController
    }

    static func profile(with loginViewModel: LoginViewModel?) -> ProfileViewController? {
        let downloadManager = DownloadManager()
        let inputs = ProfileViewModelInputs(downloadManager: downloadManager)
        let viewModel = ProfileViewModel(inputs: inputs)
        let storyboard: UIStoryboard = UIStoryboard(name: Text.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Text.Storyboard.profile) as? ProfileViewController

        viewController?.viewModel = viewModel
        viewModel.setup(with: loginViewModel)

        return viewController
    }

    static var search: SearchItemsListViewController? {
        let searchService = SearchItemService()
        let inputs = SearchItemsListViewModelInputs(search: searchService)
        let viewModel = SearchItemsListViewModel(inputs: inputs)
        let viewController = SearchItemsListViewController()

        viewController.viewModel = viewModel

        return viewController
    }
    
    static var addItem: AddItemViewController? {
        let addItemService = AddItemService()
        let categoryItemService = CategoryItemService()
        let articleItemService = ArticleItemService()

        let inputs = AddItemViewModelInputs(categoriesService: categoryItemService,
                                            articlesService: articleItemService,
                                            addItemService: addItemService)
        let viewModel = AddItemViewModel(inputs: inputs)
        let storyboard: UIStoryboard = UIStoryboard(name: Text.Storyboard.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Text.Storyboard.addItem) as? AddItemViewController

        viewController?.viewModel = viewModel

        return viewController
    }
}
