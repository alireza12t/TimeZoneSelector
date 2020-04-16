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
    @IBOutlet var changeLanguageButton: UIButton!
    
    var selectedItem: UITabBarItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.delegate = self
        setupViews()
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
        
        switch ValueKeeper.language {
        case .FA:
            changeLanguageButton.setImage(UIImage(named: "UKFlag"), for: .normal)
        case .EN:
            changeLanguageButton.setImage(UIImage(named: "PersianFlag"), for: .normal)
        }
    }
}

//MARK: - Actions
extension TabBarViewController {
    @IBAction func changeLanguageButtonDidTap(_ sender: UIButton) {
        if ValueKeeper.language == .EN {
            ValueKeeper.language = .FA
            changeLanguageButton.setImage(UIImage(named: "PersianFlag"), for: .normal)
        } else if ValueKeeper.language == .FA {
            ValueKeeper.language = .EN
            changeLanguageButton.setImage(UIImage(named: "UKFlag"), for: .normal)
        }
        UserDefaultsHelper.set(key: .Language, value: ValueKeeper.language.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name("Language"), object: nil)
        viewDidLoad()
    }
}


//MARK: - Tab Bar Delegate
extension TabBarViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item {
        case listTabBarItem:
            if selectedItem != listTabBarItem {
                listViewController.isHidden = false
                addCityViewController.isHidden = true
                selectedItem = listTabBarItem
                changeLanguageButton.isHidden = true
            }
        case addCityTabBarItem:
            if selectedItem != addCityTabBarItem {
                listViewController.isHidden = true
                addCityViewController.isHidden = false
                selectedItem = addCityTabBarItem
                changeLanguageButton.isHidden = false
            }
        default:
            break
        }
    }
    
}
