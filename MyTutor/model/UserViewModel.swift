//
//  UserViewModel.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/9/23.
//

import Foundation
import FirebaseAuth

struct UserViewModel {
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var uid: String = ""
    var isLoggedIn: Bool = false
    
    //MARK: user info
    mutating func checkUserStatus() {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            self.isLoggedIn = false
            self.email = currentUser?.email ?? ""
            self.uid = currentUser?.uid ?? ""
        } else {
            self.isLoggedIn = true
            self.email = ""
            self.uid = ""
        }
    }
    
    func resetUserPassword(_ email: String, resetCompletion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
    }
    
    //MARK: - Validation checks
    func passwordsMatch(_ confirmPW: String) -> Bool {
        return confirmPW == password
    }
    
    func isEmpty(_ field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isEmailValid(_ email: String) -> Bool {
        if email.count > 100 {
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,15}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}
