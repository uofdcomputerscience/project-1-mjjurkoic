//
//  MercuryTableViewCell.swift
//  MercuryBrowser
//
//  Created by Michael Jurkoic on 10/7/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class MercuryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mercuryName: UILabel!
    @IBOutlet weak var mercuryType: UILabel!
    @IBOutlet weak var mercuryImage: UIImageView!
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
