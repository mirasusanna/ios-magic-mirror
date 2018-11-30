//
//  Helpers.swift
//  Magic Mirror
//
//  Created by Hiltunen on 31/10/2018.
//  Copyright © 2018 Hiltunen. All rights reserved.
//

import Foundation

class Helpers {
    
    // Return formatted Dates
    static func getFormattedDate(day:Date, format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let weekday = formatter.string(from: day)
        return weekday
    }
}
