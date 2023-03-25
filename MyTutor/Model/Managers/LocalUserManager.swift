//
//  LocalUserManager.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/25/23.
//

import Foundation

class LocalUserManager: NSObject {
    let firebaseManager = FirebaseManager.shared
    
    var currentUser: UserInfo
    
    static let shared = LocalUserManager()
    
    override init() {
        currentUser = UserInfo()
        super.init();
       
        populateUserInfo()
    }
    
    func reload() {
        populateUserInfo()
    }
    
    private func populateUserInfo() {
        populateFromAuth()
        populateFromStore()
    }
    
    private func populateFromAuth() {
        self.currentUser.uid = firebaseManager.getUserId();
        self.currentUser.email = firebaseManager.getUserEmail()
    }
    
    private func populateFromStore() {
        firebaseManager.firestore.collection("users").whereField("uid", isEqualTo: firebaseManager.getUserId())
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print("about to loop document: \(querySnapshot!.documents.count)")
                    if querySnapshot!.documents.count != 0 {
                        let data = querySnapshot!.documents[0].data()
                        print("data: \(data)")
                        self.currentUser.subjects = data["subjects"] as? [String] ?? []
                    }
                }
            }
    }
}
