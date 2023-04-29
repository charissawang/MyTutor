//
//  TaskInfo.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/20/23.
//

import Foundation

struct TaskInfo: Hashable {
    var taskId: String = ""
    var from: String = ""
    var to: String = ""
    var fromDisplayName: String = ""
    var subject: String = ""
    var schedule: String = ""
    var status: String = ""
    var requestTime: Date = Date()
}
