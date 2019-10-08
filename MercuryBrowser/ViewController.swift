//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let projectURLString = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
    
    struct MercuryData: Codable {
        let mercury: [Dictionary<String, String>]
    }
    
    struct MercuryType {
        let name: String
        let type: String
        let url: String
        
        init(inputDict: Dictionary<String, String>) {
            name = inputDict["name"]!
            type = inputDict["type"]!
            url = inputDict["url"]!
        }
    }
    
    var mercuryArray: [MercuryType] = []
    
    @IBOutlet weak var mercuryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: URL(string: projectURLString)!) { (data, response, error) in
            if let data = data {
                let projectData = try! JSONDecoder().decode(MercuryData.self, from: data)
                for item in projectData.mercury {
                    self.mercuryArray.append(MercuryType(inputDict: item))
                }
            }
        }
        task.resume()
        
        setupTableView()
    }
    
    func setupTableView() {
        mercuryTableView.delegate = self
        mercuryTableView.dataSource = self
        mercuryTableView.register(MercuryTableViewCell.self, forCellReuseIdentifier: "mercuryCell")
        
        view.addSubview(mercuryTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = mercuryTableView.dequeueReusableCell(withIdentifier: "mercuryCell", for: indexPath) as! MercuryTableViewCell
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    func mercuryTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
