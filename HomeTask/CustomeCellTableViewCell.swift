//
//  CustomeCellTableViewCell.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import UIKit

class CustomeCellTableViewCell: UITableViewCell {

    @IBOutlet var view: UIView!
    @IBOutlet var cityTimeLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = .init(width: 0, height: 0)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
    }
    
}
