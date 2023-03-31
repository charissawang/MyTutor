//
//  UserInfo.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/25/23.
//

import Foundation

struct UserInfo {
    var uid: String = ""
    var email: String = ""
    var displayName: String = ""
    var description: String = ""
    var tutorMode: Int = -1
    var subjects: [String] = []
    var availableSchedules: [ScheduleInfo] = []
}
