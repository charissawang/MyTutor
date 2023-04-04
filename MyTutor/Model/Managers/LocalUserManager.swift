//
//  LocalUserManager.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/25/23.
//

import Foundation

class LocalUserManager: NSObject {
    let firebaseManager = FirebaseManager.shared
    let localDataManager = LocalDataManager.shared
    
    var currentUser: UserInfo
    
    
    static let shared = LocalUserManager()
    
    override init() {
        currentUser = UserInfo()
        super.init();
       
        populateUserInfo()
    }
    
    func reload(loadCompletion: @escaping (Result<Bool, Error>) -> Void) {
        populateFromStore(loadCompletion: loadCompletion)
    }
    
    func createOrUpdateUser() {
        print("availbeSchedules \(currentUser.availableSchedules)")
        firebaseManager.firestore.collection("users").document(currentUser.uid).setData([
            "uid": currentUser.uid,
            "email": currentUser.email,
            "tutorMode": localDataManager.getUserChoice() ?? "",
            "displayName": currentUser.displayName,
            "description": currentUser.description,
            "subjects": currentUser.subjects,
            "availableSchedules": currentUser.availableSchedules
        ]) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            
        }
    }
    
    func setUserSubject(_ subjects: [String]) {
        currentUser.subjects = subjects
    }
    
    func setDisplayName(_ name: String) {
        currentUser.displayName = name
    }
    
    func setDescription(_ desc: String) {
        currentUser.description = desc
    }
    
    func setAvailableSchedules(_ schedules: [String]) {
        currentUser.availableSchedules = schedules
    }
    
    private func populateUserInfo() {
        populateFromAuth()
        populateFromStore() { result in
            switch result {
            case .failure(let error):
                print("populateUserInfo error")
            case .success(_):
                print("populateUserInfo success")
            }
            
        }
    }
    
    private func populateFromAuth() {
        self.currentUser.uid = firebaseManager.getUserId();
        self.currentUser.email = firebaseManager.getUserEmail()
    }
    
    private func populateFromStore(loadCompletion: @escaping (Result<Bool, Error>) -> Void) {
        firebaseManager.firestore.collection("users").whereField("uid", isEqualTo: firebaseManager.getUserId())
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    loadCompletion(.failure(err))
                } else {
                    print("localUserManager about to loop users document: \(querySnapshot!.documents.count)")
                    if querySnapshot!.documents.count != 0 {
                        let data = querySnapshot!.documents[0].data()
                        print("data: \(data)")
                        self.currentUser.subjects = data["subjects"] as? [String] ?? []
                        self.currentUser.displayName = data["displayName"] as? String ?? ""
                        self.currentUser.description = data["description"] as? String ?? ""
                        self.currentUser.availableSchedules = data["availableSchedules"] as? [String] ?? []
                        loadCompletion(.success(true))
                    }
                }
            }
    }
}
