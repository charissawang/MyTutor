//
//  AccountContants.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import Foundation

struct AccountContants {
    static let USER_CHOICE = "userChoice"
    static let STUDENT_TYPE = "1"
    static let TUTOR_TYPE = "2"
    static let STUDENT_AND_TUTOR_TYPE = "3"
    
    static var DATE_FORMATTER: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    static var TIME_FORMATTER: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }

    
}
