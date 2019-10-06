//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    @IBOutlet weak var mercuryTable: UITableView!
    @IBOutlet weak var mercuryCell: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: URL(string: projectURLString)!) { (data, response, error) in
            if let data = data {
                let projectData = try! JSONDecoder().decode(MercuryData.self, from: data)
                for item in projectData.mercury {
                    self.mercuryArray.append(MercuryType(inputDict: item))
                }
                // Helper function defined elsewhere in ViewController
                self.fillTableView(dataArray: self.mercuryArray)
            }
        }
        task.resume()
    }

    func fillTableView(dataArray: [MercuryType]) {
        
    }

}
