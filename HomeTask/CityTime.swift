//
//  CityTime.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import Foundation


class CityTime: Codable{
    var hour: Int = 0
    var minute: Int = 0
    var cityName: String = ""
    
    class func areEqual(cityTime1: CityTime, cityTime2: CityTime) -> Bool{
        return cityTime1.cityName == cityTime2.cityName
    }
    
    
}
