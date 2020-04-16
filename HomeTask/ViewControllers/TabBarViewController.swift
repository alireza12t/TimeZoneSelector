//
//  ViewController.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {
    
    @IBOutlet var addCityTabBarItem: UITabBarItem!
    @IBOutlet var listTabBarItem: UITabBarItem!
    @IBOutlet var tabBar: UITabBar!
    @IBOutlet var listViewController: UIView!
    @IBOutlet var addCityViewController: UIView!
    
    var selectedItem: UITabBarItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
}


//MARK: - Setup Views
extension TabBarViewController{
    func setupViews(){
        addCityTabBarItem.title = StringHelper.addCity()
        addCityTabBarItem.image = UIImage(named: "City")
        
        listTabBarItem.title = StringHelper.citiesList()
        listTabBarItem.image = UIImage(named: "List")
        
        tabBar.selectedItem = addCityTabBarItem
        
        selectedItem = addCityTabBarItem
    }
}


extension TabBarViewController: UITableViewDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item {
        case listTabBarItem:
            if selectedItem != listTabBarItem {
                listViewController.isHidden = false
                addCityViewController.isHidden = true
            }
        case addCityTabBarItem:
            if selectedItem != addCityTabBarItem {
                listViewController.isHidden = true
                addCityViewController.isHidden = false
            }
        default:
            break
        }
    }
    
}
