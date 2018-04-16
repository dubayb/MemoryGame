//
//  StringExtension.swift
//  Library
//
//  Created by Dubay, Bryan on 4/16/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import Foundation

extension String {
    func checkOutDate() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let date = formatter.date(from: self)
        formatter.dateFormat = "MMM d, yyyy HH:MM a" //Your New Date format as per requirement change it own
        let newDate = formatter.string(from: date!)
        
        return newDate
    }
}
