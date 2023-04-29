//
//  UserInfo.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/25/23.
//

import Foundation

struct UserInfo: Hashable {
    var uid: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var displayName: String = ""
    var description: String = ""
    var tutorMode: Int = -1
    var subjects: [String] = []
    var availableSchedules: [String] = []
}
