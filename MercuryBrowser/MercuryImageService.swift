//
//  MercuryImageService.swift
//  MercuryBrowser
//
//  Created by Michael Jurkoic on 10/8/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class MercuryImageService {
    
    func getImage(for URLString: String, completion: @escaping ((URL, UIImage) -> Void)) {
        let url: URL = URL(string: URLString)!
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: url) { (data, response, error) in
            let imgURL = url
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(imgURL, image!)
                }
            }
        }
        task.resume()
    }
    
}
