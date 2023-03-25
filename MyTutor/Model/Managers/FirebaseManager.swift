//
//  FirebaseManager.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/23/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class FirebaseManager: NSObject {
    
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()

        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
    
    func isUserLoggedIn() -> Bool {
        let currentUser = self.auth.currentUser
        
        return currentUser?.uid != nil
    }
    
    func getUserId () -> String {
        return self.auth.currentUser?.uid ?? ""
    }
    
    func getUserEmail()-> String {
        return self.auth.currentUser?.email ?? ""
    }
    
}

