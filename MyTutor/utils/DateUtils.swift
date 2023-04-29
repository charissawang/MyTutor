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
    
    static func sortDate(_ ds : [String]) -> [String] {
        return ds.sorted { (s1: String, s2: String) -> Bool in
            let (startDate1, endDate1) = toDate(s1)
            let (startDate2, endDate2) = toDate(s2)

            guard let startDate1 = startDate1, let endDate1 = endDate1, let startDate2 = startDate2, let endDate2 = endDate2 else {
                return false
            }

            return startDate1 == startDate2 ? endDate1 < endDate2 : startDate1 < startDate2
        }
    }

    static func toDate(_ s: String) -> (Date?, Date?) {
        let r = /^(?<date>[^\t]+)\t(?<start>.+)\s-\s(?<end>.+)$/
        if let result = try? r.wholeMatch(in: s) {
            let (date, start, end) = (String(result.date), String(result.start), String(result.end))
            return (combineDateTime(date: date, time: start), combineDateTime(date: date, time: end))
        }
        return (.none, .none)
    }

    static func combineDateTime(date : String, time : String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a"
        return formatter.date(from: date + " at " + time)!
    }

    static func search(_ ds: [String], _ date: String) -> [String] {
        let (comparedStart, comparedEnd) = toDate(date)
        guard let comparedStart = comparedStart, let comparedEnd = comparedEnd else {
            return ds
        }

        return ds.filter {
            let (start, end) = toDate($0)
            guard let start = start, let end = end else {
                return false
            }
            return start <= comparedStart && comparedEnd <= end
        }
    }
    
    static func isPastSchedule(_ schedule: String) -> Bool{
        let (start, _) = toDate(schedule)
        guard let start = start else {
            return true
        }
        return start < Date.now
        // return false
    }
}
