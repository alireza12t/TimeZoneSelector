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
        var currentTimeZoneAbbreviation = TimeZone.current.abbreviation()!
        var currentHour = 0
        var currentMinute = 0
        currentTimeZoneAbbreviation.removeFirst()
        currentTimeZoneAbbreviation.removeFirst()
        currentTimeZoneAbbreviation.removeFirst()
        if currentTimeZoneAbbreviation != ""{
            let sign = currentTimeZoneAbbreviation.removeFirst()
            if sign == "+" {
                switch currentTimeZoneAbbreviation.split(separator: ":").count {
                case 1:
                    currentHour = -Int(String((currentTimeZoneAbbreviation.split(separator: ":")[0])))!
                case 2:
                    currentHour = -Int(String((currentTimeZoneAbbreviation.split(separator: ":")[0])))!
                    currentMinute = -Int(String((currentTimeZoneAbbreviation.split(separator: ":")[1])))!
                default:
                    break
                }
            } else if sign == "-" {
                switch currentTimeZoneAbbreviation.split(separator: ":").count {
                case 1:
                    currentHour = +Int(String((currentTimeZoneAbbreviation.split(separator: ":")[0])))!
                case 2:
                    currentHour = +Int(String((currentTimeZoneAbbreviation.split(separator: ":")[0])))!
                    currentMinute = +Int(String((currentTimeZoneAbbreviation.split(separator: ":")[1])))!
                default:
                    break
                }
            }
        }

        var timeZoneList: [CityTime] = []
        for tz in TimeZone.knownTimeZoneIdentifiers {
            let timeZone = TimeZone(identifier: tz)
            if var abbreviation = timeZone?.abbreviation() {
                let item = CityTime()
                let date = Date()
                let calendar = Calendar.current
                item.hour = calendar.component(.hour, from: date) + currentHour
                item.minute = calendar.component(.minute, from: date) + currentMinute
                
                if tz.split(separator: "/").count == 2{
                    item.cityName = String(tz.split(separator: "/")[1])
                    print("city => \(item.cityName) => \(abbreviation)")
                    if abbreviation == "GMT" {
                         timeZoneList.append(item)
                    } else {
                    abbreviation.removeFirst()
                    abbreviation.removeFirst()
                    abbreviation.removeFirst()
                    if abbreviation.split(separator: ":").count > 0 {
                        let sign = abbreviation.removeFirst()
                        print("current time =>  \(item.hour):\(item.minute), GMT => \(abbreviation.split(separator: ":"))")
                        if sign == "+" {
                            item.hour += Int(String(abbreviation.split(separator: ":")[0]))!
                       
                            
                            if abbreviation.split(separator: ":").count == 2{
                                
                                item.minute += Int(String(abbreviation.split(separator: ":")[1]))!
                              
                            }
                            if item.minute <= 0{
                                item.minute += 60
                                item.hour -= 1
                                
                            }
                            
                            if item.minute >= 60{
                                item.minute -= 60
                                item.hour += 1
                            }
                            
                            if item.hour <= 0{
                                item.hour += 24
                            }
                            timeZoneList.append(item)
                        } else if sign == "-"  {
                            item.hour -= Int(String(abbreviation.split(separator: ":")[0]))!
                            
                            if abbreviation.split(separator: ":").count == 2{
                                item.minute -= Int(String(abbreviation.split(separator: ":")[1]))!
                            }
                            if item.minute <= 0{
                                item.minute += 60
                                item.hour -= 1
                                
                            }
                            
                            if item.minute >= 60{
                                item.minute -= 60
                                item.hour += 1
                            }
                            
                            if item.hour <= 0{
                                item.hour += 24
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
        timeZoneList = timeZoneList.sorted { $0.cityName.lowercased() < $1.cityName.lowercased() }
        return timeZoneList
    }
}
