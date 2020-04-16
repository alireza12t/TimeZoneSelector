//
//  StringHelper.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import Foundation


/// This class used for getting Farsi words and sentences
class StringHelper {

    class func ok() -> String{
        switch ValueKeeper.language {
        case .FA:
            return "متوجه شدم"
        case .EN:
            return "OK"
        }
    }
    
    class func error() -> String{
        switch ValueKeeper.language {
        case .FA:
            return "مشکلی پیش آمده"
        case .EN:
            return "Error"
        }
    }
    
    class func edit() -> String{
        switch ValueKeeper.language {
        case .FA:
            return "ویرایش"
        case .EN:
            return "Edit"
        }
    }
    
    class func clear() -> String{
        switch ValueKeeper.language {
        case .FA:
            return "پاک کردن لیست"
        case .EN:
            return "Clear"
        }
    }
    
    class func citiesList() -> String{
        switch ValueKeeper.language {
        case .FA:
            return "لیست شهرها"
        case .EN:
            return "List of Cities"
        }
    }
    
}
