//
//  SubjectViewModel.swift
//  MyTutor
//
//  Created by Charissa wang on 3/14/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class SubjectViewModel: ObservableObject {
    @Published var subjectItems = [String]()
    @Published var userSubjects = [String]()
    private var db = Firestore.firestore()
    private var currentTutor = TutorInfo()
    
    func fetchAllSubjects() {
        db.collection("subjects").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.subjectItems = documents.map { (queryDocumentSnapshot) -> String in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                return name
            }
        }
    }
    
    func fetchUserSubjects(_ userId: String) {
        db.collection("tutors").whereField("uid", isEqualTo: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print("about to loop document: \(querySnapshot!.documents.count)")
                    if querySnapshot!.documents.count == 0 {
                        self.userSubjects = []
                    } else {
                        let data = querySnapshot!.documents[0].data()
                        print("data: \(data)")
                        self.userSubjects = data["subjects"] as? [String] ?? []
                        print("userSubjects: \(self.userSubjects)")
                        self.currentTutor.uid = userId
                        self.currentTutor.subjects = self.userSubjects
                    }
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                    }
                }
        }
    }
    
    func createUserSubjects(_ subjects: [String]) {
        let uid = Auth.auth().currentUser?.uid ?? "0"

        print("subjects count: \(subjects.count)")
        for s in subjects {
            print("s = \(s)")
        }
        
        if subjects.count == 0 || uid == "0" {
            return
        }
        
        db.collection("tutors").document(uid).setData([
            "uid": uid,
            "subjects": subjects
        ]) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            
        }
    }
}
