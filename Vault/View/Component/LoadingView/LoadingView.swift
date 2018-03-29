//
//  LoadingView.swift
//  Vault
//
//  Created by Lusine Sargsyan on 2/27/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    @IBOutlet weak var imageView: UIImageView!

    private var images: [UIImage] {
        var images = [UIImage]()

        for imageId in 0...29 {
            let strImageName : String = "spinner-\(imageId)"
            if let image  = UIImage(named: strImageName) {
                images.append(image)
            }
        }

        return images
    }

    private var isAnimating: Bool = false

    func animate() {
        guard isAnimating == false else { return }

        self.isAnimating = true
        self.imageView.animationImages = images
        self.imageView.animationRepeatCount = .max
        self.imageView.animationDuration = 1
        self.imageView.startAnimating()
    }

    func stop() {
        guard isAnimating == true else { return }

        self.isAnimating = false
        self.imageView.stopAnimating()
    }
}
