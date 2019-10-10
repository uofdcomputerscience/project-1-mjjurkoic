//
//  MercuryImageService.swift
//  MercuryBrowser
//
//  Created by Michael Jurkoic on 10/8/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class MercuryImageService {
    
    var imageDictionary: Dictionary<String, String>
    
    init() {
        imageDictionary = [:]
    }
    
    func addEntry(name: String, URLString: String) {
        self.imageDictionary[name] = URLString
    }
    
    func getImage(for name: String, completion: @escaping ((URL, UIImage) -> Void)) {
        let url: URL = URL(string: name)!
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(url, image!)
                }
            }
        }
        task.resume()
    }
}
