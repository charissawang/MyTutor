//
//  SubjectViewModel.swift
//  MyTutor
//
//  Created by Charissa wang on 3/14/23.
//

import Foundation
import FirebaseFirestore

class SubjectViewModel: ObservableObject {
    @Published var subjectItems = [String]()
    @Published var userSubjects = [String]()
    private var db = Firestore.firestore()
    
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
        db.collection("tutors").whereField("userId", isEqualTo: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print("about to loop document: \(querySnapshot!.documents.count)")
                    if querySnapshot!.documents.count == 0 {
                        self.userSubjects = []
                    } else {
                        let data = querySnapshot!.documents[0].data()
                        self.userSubjects = data["subjects"] as? [String] ?? []
                    }
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                    }
                }
        }
    }
    
    func createUserSubjects(_ userId: String, _ subjects: [String]) {
        let docData: [String: Any] = [
            "userId": userId,
            "subjects": subjects,
            "dateAdded": Timestamp(date: Date()),
        ]
        let docRef = db.collection("UserSubjects").document(userId)
        docRef.setData(docData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
