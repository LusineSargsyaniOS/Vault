//
//  DownloadManager.swift
//  Vault
//
//  Created by Lusine Sargsyan on 3/4/18.
//  Copyright © 2018 Lusine Sargsyan. All rights reserved.
//

import Foundation

final class DownloadManager {
    func downloadDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
}
