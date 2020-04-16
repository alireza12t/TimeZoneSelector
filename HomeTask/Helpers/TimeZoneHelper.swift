//
//  TimeZoneHelper.swift
//  HomeTask
//
//  Created by ali on 4/17/20.
//  Copyright © 2020 ali. All rights reserved.
//

import Foundation



class TimeZoneHelper {
    class func makeTimeZoneList() -> [CityTime]{
        var timeZoneList: [CityTime] = []
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
        timeZoneList = timeZoneList.sorted { $0.cityName.lowercased() < $1.cityName.lowercased() }
        return timeZoneList
    }
}
