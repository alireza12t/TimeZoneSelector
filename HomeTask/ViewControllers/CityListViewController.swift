//
//  CityListViewController.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import UIKit



class CityListViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var topBar: UIView!
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        setupViews()
        
        listTableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: NSNotification.Name("UpdateTableView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: NSNotification.Name("Language"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("UpdateTableView"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Language"), object: nil)
    }
    
    
    
    
    
}

//MARK: - Setup Views
extension CityListViewController {
    func setupViews(){
        clearButton.setTitle(StringHelper.clear(), for: .normal)
//        editButton.setTitle(StringHelper.edit(), for: .normal)
        if AddCityViewController.citiesList.count == 0{
            clearButton.isHidden = true
//            editButton.isHidden = true
        } else {
            clearButton.isHidden = false
//            editButton.isHidden = false
        }
        titleLabel.text = StringHelper.addCity()
        topBar.layer.shadowColor = UIColor.darkGray.cgColor
        topBar.layer.shadowOffset = .init(width: 0, height: 0)
        topBar.layer.shadowRadius = 3
        topBar.layer.shadowOpacity = 0.5
    }
}

//MARK: - Actions
extension CityListViewController {
    @objc func changeLanguage(){
        setupViews()
    }
    
    @objc func updateTableView() {
        listTableView.reloadData()
        setupViews()
    }
    
    @IBAction func clearListButtonDidTap(_ sender: Any) {
        AddCityViewController.citiesList = []
        listTableView.reloadData()
        setupViews()
    }
    
    @IBAction func editButtonDidTap(_ sender: Any) {
//        listTableView.allowsMultipleSelection = true
//        
//        
//        
//        
//        
//        
//        listTableView.allowsMultipleSelection = false
    }
}

//MARK: - Table View Delegate
extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddCityViewController.citiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomeCellTableViewCell", for: indexPath) as! CustomeCellTableViewCell
        let cellData = AddCityViewController.citiesList[indexPath.row]
        
        
        cell.cityNameLabel.text = cellData.cityName
        
        if cellData.hour >= 10 {
            if cellData.minute >= 10 {
                cell.cityTimeLabel.text = "\(cellData.hour):\(cellData.minute)"
            } else {
                cell.cityTimeLabel.text = "\(cellData.hour):0\(cellData.minute)"
            }
        } else {
            cell.cityTimeLabel.text = "0\(cellData.hour):0\(cellData.minute)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AddCityViewController.citiesList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setupViews()
        }
    }
}
