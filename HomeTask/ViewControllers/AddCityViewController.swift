//
//  SelectCityViewController.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    @IBOutlet var topBar: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var changeLanguageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ValueKeeper.language = Language(rawValue: UserDefaultsHelper.get(key: .Language) ?? "ENGLISH") ?? .EN
        setupViews()
    }
    
    
    
    
    
    
}

//MARK: - Setup Views
extension AddCityViewController {
    func setupViews(){
        titleLabel.text = StringHelper.addCity()
        
        addButton.setTitle(StringHelper.add(), for: .normal)
        
        topBar.layer.shadowColor = UIColor.darkGray.cgColor
        topBar.layer.shadowOffset = .init(width: 0, height: 0)
        topBar.layer.shadowRadius = 3
        topBar.layer.shadowOpacity = 0.5
        
        switch ValueKeeper.language {
        case .FA:
            changeLanguageButton.imageView?.image = UIImage(named: "UKFlag")
        case .EN:
            changeLanguageButton.imageView?.image = UIImage(named: "PersianFlag")
        }
    }
}


//MARK: - Actions
extension AddCityViewController {
    func showErrorView(){
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let vc = ErrorViewController()
                vc.errorMessage = StringHelper.duplicateErrorMessage()
                self.present(vc, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "ErrorSegue", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ErrorSegue" {
            let vc = segue.destination as? ErrorViewController
            if true {
                vc?.errorMessage = StringHelper.duplicateErrorMessage()
            }
        }
    }
    
    
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        
    }
    
    @IBAction func changeLanguageButtonDidTap(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "PersianFlag") {
            ValueKeeper.language = .FA
            sender.imageView?.image = UIImage(named: "UKFlag")
            viewDidAppear(false)
        } else if sender.imageView?.image == UIImage(named: "UKFlag") {
            ValueKeeper.language = .EN
            sender.imageView?.image = UIImage(named: "PersianFlag")
            viewDidAppear(false)
        }
        UserDefaultsHelper.set(key: .Language, value: ValueKeeper.language.rawValue)
    }
}
