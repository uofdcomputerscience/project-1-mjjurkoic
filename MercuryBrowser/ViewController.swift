//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    var cellData: MercuryData = MercuryData(mercury: [])

    let mercuryImageService = MercuryImageService()
    
    let projectURLString = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
    
    struct MercuryData: Codable {
        let mercury: [MercuryType]
    }
    
    struct MercuryType: Codable {
        let name: String
        let type: String
        let url: String
    }
    
    @IBOutlet weak var mercuryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mercuryTableView.dataSource = self
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: URL(string: projectURLString)!) { (data, response, error) in
            if let data = data {
                self.cellData = try! JSONDecoder().decode(MercuryData.self, from: data)
            }
            DispatchQueue.main.async {
                self.mercuryTableView.reloadData()
            }
        }
        task.resume()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(cellData.mercury.count)
        return cellData.mercury.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = mercuryTableView.dequeueReusableCell(withIdentifier: "mercuryCell", for: indexPath) as! MercuryTableViewCell
        self.mercuryImageService.getImage(for: self.cellData.mercury[indexPath.row].url) { (url, img) in
            let name = self.cellData.mercury[indexPath.row].name
            let type = self.cellData.mercury[indexPath.row].type
            let image = img
            cell.name.text = name
            cell.type.text = type
            cell.img.image = image
        }
        
        return cell
    }
    
}
