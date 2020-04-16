//
//  ValueKeeper.swift
//  carpino-passenger-ios-swift
//
//  Created by negar on 98/Azar/04 AP.
//  Copyright © 1398 carpino corp. All rights reserved.
//

import Foundation
import UIKit

enum Language: String {
    case FA = "Persian"
    case EN = "English"
}


///This class is definition of storing some internal Values
class ValueKeeper {

    ///App Language
    static var language: Language = .EN

}
