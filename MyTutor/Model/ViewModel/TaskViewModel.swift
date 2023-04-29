//
//  TaskViewModel.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/20/23.
//

import Foundation

class TaskViewModel: ObservableObject {
    private var db = FirebaseManager.shared.firestore
    
    @Published var requstedTasks: [TaskInfo] = [TaskInfo]()
    @Published var confirmedTasks: [TaskInfo] = [TaskInfo]()
    @Published var upcomingConfirmedTasks: [TaskInfo] = [TaskInfo]()
    @Published var pastConfirmedTasks: [TaskInfo] = [TaskInfo]()
    @Published var confirmedLessons: [TaskInfo] = [TaskInfo]()
    @Published var upcomingConfirmedLessons: [TaskInfo] = [TaskInfo]()
    @Published var pastConfirmedLessons: [TaskInfo] = [TaskInfo]()
    
    
    func loadTutorConfirmedTask(_ toEmail: String) {
        
        let collectionRef = db.collection("taskrequest")
        let query = collectionRef.whereField("to", isEqualTo: toEmail)
                        .whereField("status", isEqualTo: "confirmed")
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            
            var pastTasks: [TaskInfo] = [TaskInfo]()
            var upcomingTasks: [TaskInfo] = [TaskInfo]()
            self.confirmedTasks = documents.map { (queryDocumentSnapshot) -> TaskInfo in
               
                let data = queryDocumentSnapshot.data()
                var taskInfo = TaskInfo()
                taskInfo.from = data["from"] as? String ?? ""
                taskInfo.to = data["to"] as? String ?? ""
                taskInfo.subject = data["subject"] as? String ?? ""
                taskInfo.schedule = data["schedule"] as? String ?? ""
                taskInfo.taskId = data["taskid"] as? String ?? ""
                taskInfo.fromDisplayName = data["fromDisplayName"] as? String ?? ""
                taskInfo.requestTime = data["requesttime"] as? Date ?? Date()
                
                if DateUtils.isPastSchedule(taskInfo.schedule) {
                    pastTasks.append(taskInfo)
                } else {
                    upcomingTasks.append(taskInfo)
                }
                
                return taskInfo
            }
            
            self.upcomingConfirmedTasks = upcomingTasks
            self.pastConfirmedTasks = pastTasks
        }
    }
    
    func loadTutorRequestedTasks(_ toEmail: String) {
        let now = Date()
        let fiveMinutesAgo = now.addingTimeInterval(-300000) // 300 seconds = 5 minutes
        
        let collectionRef = db.collection("taskrequest")
        let query = collectionRef.whereField("to", isEqualTo: toEmail)
                        .whereField("status", isEqualTo: "requested")
                        .whereField("requesttime", isGreaterThanOrEqualTo: fiveMinutesAgo)
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            
            
            self.requstedTasks = documents.map { (queryDocumentSnapshot) -> TaskInfo in
               
                let data = queryDocumentSnapshot.data()
                var taskInfo = TaskInfo()
                taskInfo.from = data["from"] as? String ?? ""
                taskInfo.to = data["to"] as? String ?? ""
                taskInfo.subject = data["subject"] as? String ?? ""
                taskInfo.schedule = data["schedule"] as? String ?? ""
                taskInfo.taskId = data["taskid"] as? String ?? ""
                taskInfo.fromDisplayName = data["fromDisplayName"] as? String ?? ""
                taskInfo.requestTime = data["requesttime"] as? Date ?? Date()
                
                return taskInfo
            }
        }
    }
    
    func loadStudentConfirmedLessons(_ fromEmail: String) {
        
        let collectionRef = db.collection("taskrequest")
        let query = collectionRef.whereField("from", isEqualTo: fromEmail)
                        .whereField("status", isEqualTo: "confirmed")
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            
            var pastLessons: [TaskInfo] = [TaskInfo]()
            var upcomingLessons: [TaskInfo] = [TaskInfo]()
            self.confirmedLessons = documents.map { (queryDocumentSnapshot) -> TaskInfo in
               
                let data = queryDocumentSnapshot.data()
                var taskInfo = TaskInfo()
                taskInfo.from = data["from"] as? String ?? ""
                taskInfo.to = data["to"] as? String ?? ""
                taskInfo.subject = data["subject"] as? String ?? ""
                taskInfo.schedule = data["schedule"] as? String ?? ""
                taskInfo.taskId = data["taskid"] as? String ?? ""
                taskInfo.fromDisplayName = data["fromDisplayName"] as? String ?? ""
                taskInfo.requestTime = data["requesttime"] as? Date ?? Date()
                
                if DateUtils.isPastSchedule(taskInfo.schedule) {
                    pastLessons.append(taskInfo)
                } else {
                    upcomingLessons.append(taskInfo)
                }
                
                return taskInfo
            }
            
            self.upcomingConfirmedLessons = upcomingLessons
            self.pastConfirmedLessons = pastLessons
            
            print("confirmedLessons : \(self.upcomingConfirmedLessons)")
        }
    }
    
    func updateTaskStatus(_ task: TaskInfo, _ status: String, updateCompleted: @escaping (Result<Bool, Error>) -> Void) {
        db.collection("taskrequest").document(task.taskId).setData([
            "taskid": task.taskId,
            "from": task.from,
            "fromDisplayName": task.fromDisplayName,
            "to": task.to,
            "subject": task.subject,
            "schedule": task.schedule,
            "requesttime": task.requestTime,
            "status": status
        ]) { error in
                if let error = error {
                    updateCompleted(.failure(error))
                } else {
                    updateCompleted(.success(true))
                }
        }
    }
}
