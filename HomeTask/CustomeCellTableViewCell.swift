//
//  CustomeCellTableViewCell.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import UIKit

class CustomeCellTableViewCell: UITableViewCell {

    @IBOutlet var cellView: UIView!
    @IBOutlet var cityTimeLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        cellView.layer.masksToBounds = false
        cellView.layer.cornerRadius = 25
        cellView.layer.shadowColor = UIColor.darkGray.cgColor
        cellView.layer.shadowOffset = .init(width: 0, height: 0)
        cellView.layer.shadowRadius = 3
        cellView.layer.shadowOpacity = 0.5
    }
    
}
