//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mercuryArray: [MercuryType] = []

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
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: URL(string: projectURLString)!) { (data, response, error) in
            if let data = data {
                let projectData = try! JSONDecoder().decode(MercuryData.self, from: data)
                self.mercuryArray = projectData.mercury
                print(self.mercuryArray)
                print(projectData.mercury)
                for item in projectData.mercury {
                    self.mercuryImageService.addEntry(name: item.name, URLString: item.url)
                }
            }
            DispatchQueue.main.async {
                self.mercuryTableView.reloadData()
                self.setupTableView()
            }
        }
        task.resume()
    }
    
    func setupTableView() {
        mercuryTableView.delegate = self
        mercuryTableView.dataSource = self
        mercuryTableView.register(MercuryTableViewCell.self, forCellReuseIdentifier: "mercuryCell")
        
        view.addSubview(mercuryTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mercuryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = mercuryTableView.dequeueReusableCell(withIdentifier: "mercuryCell", for: indexPath) as! MercuryTableViewCell
        self.mercuryImageService.getImage(for: self.mercuryArray[indexPath.row].url) { (url, image) in
            cell.mercuryName.text = self.mercuryArray[indexPath.row].name
            cell.mercuryType.text = self.mercuryArray[indexPath.row].type
            cell.mercuryImage.image = image
        }
        
        return cell
    }
    
    func mercuryTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
