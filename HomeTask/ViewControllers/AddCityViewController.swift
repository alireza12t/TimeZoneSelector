//
//  SelectCityViewController.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    
    @IBOutlet var pickerViewTextField: UITextField!
    @IBOutlet var topBar: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    
    var timeZoneList: [CityTime] = []
    var response: CityTime? = nil
    var cityPickerView = UIPickerView()
    static var citiesList: [CityTime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ValueKeeper.language = Language(rawValue: UserDefaultsHelper.get(key: .Language) ?? "ENGLISH") ?? .EN
        setupViews()
        makeTimeZoneList()
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerViewTextField.inputView = pickerView
        pickerViewTextField.delegate = self
        makePickerViewToolBar()
        response = timeZoneList[0]
        pickerViewTextField.text = response?.cityName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: NSNotification.Name("Language"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Language"), object: nil)
    }
    
    
    func makeTimeZoneList(){
        for tz in TimeZone.knownTimeZoneIdentifiers {
            let timeZone = TimeZone(identifier: tz)
            if var abbreviation = timeZone?.abbreviation() {
                let item = CityTime()
                let date = Date()
                let calendar = Calendar.current
                item.hour = calendar.component(.hour, from: date)
                item.minute = calendar.component(.minute, from: date)
                if tz.split(separator: "/").count == 2{
                    item.cityName = String(tz.split(separator: "/")[1])
                    abbreviation.removeFirst()
                    abbreviation.removeFirst()
                    abbreviation.removeFirst()
                    if abbreviation.split(separator: ":").count > 0 {
                        let sign = abbreviation.removeFirst()
                        if sign == "+" {
                            item.hour += Int(String(abbreviation.split(separator: ":")[0]))!
                            if item.hour < 0 {
                                item.hour += 24
                            } else if item.hour > 24 {
                                item.hour -= 24
                            }
                            
                            if abbreviation.split(separator: ":").count == 2{
                                
                                item.minute += Int(String(abbreviation.split(separator: ":")[1]))!
                                if item.minute >= 60 {
                                    item.minute -= 60
                                    item.hour += 1
                                } else if item.minute <= 0 {
                                    item.minute += 60
                                    item.hour -= 1
                                }
                            }
                            timeZoneList.append(item)
                        } else if sign == "-"  {
                            item.hour -= Int(String(abbreviation.split(separator: ":")[0]))!
                            if item.hour < 0 {
                                item.hour += 24
                            } else if item.hour > 24 {
                                item.hour -= 24
                            }
                            
                            if abbreviation.split(separator: ":").count == 2{
                                item.minute -= Int(String(abbreviation.split(separator: ":")[1]))!
                                if item.minute >= 60 {
                                    item.minute -= 60
                                    item.hour += 1
                                } else if item.minute <= 0 {
                                    item.minute += 60
                                    item.hour -= 1
                                }
                            }
                            timeZoneList.append(item)
                        } else {
                            if Int(abbreviation) == 0 {
                                timeZoneList.append(item)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
}

//MARK: - Setup Views
extension AddCityViewController {
    func setupViews(){
        titleLabel.text = StringHelper.addCity()
        
        addButton.setTitle(StringHelper.add(), for: .normal)
        addButton.layer.cornerRadius = 14
        
        topBar.layer.shadowColor = UIColor.darkGray.cgColor
        topBar.layer.shadowOffset = .init(width: 0, height: 0)
        topBar.layer.shadowRadius = 3
        topBar.layer.shadowOpacity = 0.5
        
    }
}


//MARK: - Actions
extension AddCityViewController {
    @objc func changeLanguage(){
        setupViews()
    }
    
    func showErrorView(){
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ErrorViewController") as! ErrorViewController
                
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
            vc?.errorMessage = StringHelper.duplicateErrorMessage()
        }
    }
    
    func makePickerViewToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: StringHelper.done(), style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        pickerViewTextField.inputAccessoryView = toolBar
    }
    @objc func action() {
        view.endEditing(true)
    }
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        if let response = response {
            //            var list: [CityTime] = UserDefaultsHelper.get(key: .CitiesList)
            
            var condition = false
            for item: CityTime in AddCityViewController.citiesList {
                condition = condition || CityTime.areEqual(cityTime1: item, cityTime2: response)
            }
            if !condition {
                AddCityViewController.citiesList.append(response)
                NotificationCenter.default.post(name: NSNotification.Name("UpdateTableView"), object: nil)
                //                UserDefaultsHelper.set(key: .CitiesList, value: list)
            } else {
                showErrorView()
            }
        }
    }
    
}





extension AddCityViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeZoneList.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        response = timeZoneList[row]
        pickerViewTextField.text = response?.cityName
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.text = timeZoneList[row].cityName
        
        return label
    }
}
