//
//  BackgroundImagedViewController.swift
//  Vault_iOS
//
//  Created by Lusine Sargsyan on 2/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class BackgroundImagedViewController<Type: ViewModeling>: ViewController<Type> {
    var backgroundImage: UIImage {
        return #imageLiteral(resourceName: "backgroundImage")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundImageView()
    }
    
    private func setupBackgroundImageView() {
        let backgroundImageView = UIImageView()

        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.addInto(superView: self.view)
        self.view.sendSubview(toBack: backgroundImageView)
    }
}
