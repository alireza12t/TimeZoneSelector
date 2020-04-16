//
//  CityListViewController.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import UIKit



class CityListViewController: UIViewController {
    
    @IBOutlet var topBar: UIView!
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    
    var cityList: [CityTime] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
}

//MARK: - Setup Views
extension CityListViewController {
    func setupViews(){
        clearButton.setTitle(StringHelper.clear(), for: .normal)
        editButton.setTitle(StringHelper.edit(), for: .normal)
        if cityList.count == 0{
            clearButton.isHidden = true
            editButton.isHidden = true
        } else {
            clearButton.isHidden = false
            editButton.isHidden = false
        }
        
        topBar.layer.shadowColor = UIColor.darkGray.cgColor
        topBar.layer.shadowOffset = .init(width: 0, height: 0)
        topBar.layer.shadowRadius = 3
        topBar.layer.shadowOpacity = 0.5
    }
}

//MARK: - Actions
extension CityListViewController {
    
}

//MARK: - Table View Delegate
extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomeCellTableViewCell", for: indexPath) as! CustomeCellTableViewCell
        let cellData = cityList[indexPath.row]
        if let hour = cellData.hour{
            if let minute = cellData.minute {
                if let name = cellData.cityName {
                    
                    cell.cityNameLabel.text = name
                    
                    if cellData.hour! >= 10 {
                        if cellData.minute! >= 10 {
                            cell.cityTimeLabel.text = "\(hour):\(minute)"
                        } else {
                            cell.cityTimeLabel.text = "\(hour):0\(minute)"
                        }
                    } else {
                        cell.cityTimeLabel.text = "0\(hour):0\(minute)"
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
