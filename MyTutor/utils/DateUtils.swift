//
//  DateUtils.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/1/23.
//

import Foundation

struct DateUtils {
    static func validateDateSelection(_ date:Date) -> Bool {
        let order = NSCalendar.current.compare(date, to: Date.now, toGranularity: .day)
        switch order {
        case .orderedAscending:
            return false
        default:
            return true
        }
    }
    
    static func validateTimeSelection(_ startTime: Date, _ endTime: Date) -> Bool {
        //print("startTime = \(startTime); endTime = \(endTime); startTime < endTime = \(startTime < endTime)")
        return startTime < endTime
    }
    
    static func validateDateTimeSelection(date: Date, startTime: Date, endTime: Date) -> Bool{
        if validateDateSelection(date) == true && validateTimeSelection(startTime, endTime) {
            return true
        }
        
        return false
    }
}
