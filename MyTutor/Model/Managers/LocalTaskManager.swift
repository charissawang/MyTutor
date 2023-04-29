//
//  LocalTaskManager.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/20/23.
//

import Foundation

class LocalTaskManager: NSObject {
    let firebaseManager = FirebaseManager.shared
    
    static let shared = LocalTaskManager()
    
    func createTask(_ fromUser: UserInfo, _ toUser: UserInfo, _ subject: String, _ schedule: String) {
        let taskId = UUID().uuidString
        firebaseManager.firestore.collection("taskrequest").document(taskId).setData([
            "taskid": taskId,
            "from": fromUser.email,
            "fromDisplayName": fromUser.displayName,
            "to": toUser.email,
            "subject": subject,
            "schedule": schedule,
            "requesttime": Date(),
            "status": "requested"
        ]) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document TaskRequest successfully written!")
                }
            
        }
    }
}
