//
//  StudentHomeViewModel.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/13/23.
//

import Foundation

class StudentHomeViewModel: ObservableObject {
    var firebaseManager = FirebaseManager.shared
    
    @Published var availableTutors = [UserInfo]()
    @Published var isLoadingTutors: Bool = false
    @Published var tutorLoaded: Bool = false
    
    private var db = FirebaseManager.shared.firestore
    
    func findTuturs(_ subject: String, _ schedule: String) {
        self.isLoadingTutors = true
        self.tutorLoaded = false
        
        var userList = [UserInfo]()
        
        db.collection("users").whereField("subjects", arrayContains: subject)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) ========> \(document.data())")
                        
                        let data = querySnapshot!.documents[0].data()
                        let availableSchedules = data["availableSchedules"] as? [String] ?? []
                        let matchedSchedules = DateUtils.search(availableSchedules, schedule)
                        if matchedSchedules.count > 0 {
                            var user = UserInfo()
                            user.displayName = data["displayName"] as? String ?? ""
                            user.description = data["description"] as? String ?? ""
                            user.email = data["email"] as? String ?? ""
                            userList.append(user)
                        }
                    }
                }
                self.availableTutors = userList
            }
        self.isLoadingTutors = false
        self.tutorLoaded = true
    }
}
