//
//  UserDefaultsHelper.swift
//  GTalogue
//
//  Created by negar on 99/Farvardin/12 AP.
//  Copyright © 1399 negar. All rights reserved.
//

import Foundation

enum userDefaultsKeys: String{
    case Language, CitiesList
}




class UserDefaultsHelper {
    
    class func set(key: userDefaultsKeys, value: Bool){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    class func set(key: userDefaultsKeys, value: String){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    class func set(key: userDefaultsKeys, value: Int){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    class func set(key: userDefaultsKeys, value: [CityTime]) {
        let theData = NSKeyedArchiver.archivedData(withRootObject: value)
        UserDefaults.standard.set(theData, forKey: key.rawValue)
    }
    
    class func get(key: userDefaultsKeys) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    class func get(key: userDefaultsKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }

    class func get(key: userDefaultsKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    class func get(key: userDefaultsKeys) -> [CityTime] {
        let theData: Data? = UserDefaults.standard.data(forKey: key.rawValue)
        if theData != nil {
            return (NSKeyedUnarchiver.unarchiveObject(with: theData!) as? [CityTime]) ?? []
        } else {
            return []
        }
        
    }

    class func remove(key: userDefaultsKeys) {
        UserDefaults.standard.set(nil, forKey: key.rawValue)
    }
}
