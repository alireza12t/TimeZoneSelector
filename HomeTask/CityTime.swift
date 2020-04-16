//
//  CityTime.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import Foundation


class CityTime {
    var hour: Int? = nil
    var minute: Int? = nil
    var cityName: String? = nil
    
    class func areEqual(cityTime1: CityTime, cityTime2: CityTime) -> Bool{
        return cityTime1.cityName == cityTime2.cityName
    }
    
    
}
