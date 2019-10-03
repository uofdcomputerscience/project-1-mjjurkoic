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
    
    struct ProjectData: Codable {
        let projectDataList: [[String]]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: URL(string: projectURLString)!) { (data, response, error) in
            let projectData = try! JSONDecoder().decode(ProjectData.self, from: data!)
        }
    }


}
