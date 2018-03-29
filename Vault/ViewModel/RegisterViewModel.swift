//
//  RegisterViewModel.swift
//  Vault_iOS
//
//  Created by Lusine Sargsyan on 2/23/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

final class RegisterViewModel: ViewModel<Void> {
    var urlRequest: URLRequest? {
        guard let url = URL(string: Text.URLPaths.registrationWebPage) else { return nil }

        return URLRequest(url: url)
    }
}
