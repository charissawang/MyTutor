//
//  UserViewModel.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/9/23.
//

import Foundation
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var currentUser: UserInfo = UserInfo()
    @Published var subjects: [String] = []
    
    var localUserManager = LocalUserManager.shared
    
//    var email: String = ""
//    var password: String = ""
//    var confirmPassword: String = ""
//    var uid: String = ""
//    var isLoggedIn: Bool = false
//    
//    //MARK: user info
//    mutating func checkUserStatus() {
//        let currentUser = Auth.auth().currentUser
//        if currentUser != nil {
//            self.isLoggedIn = false
//            self.email = currentUser?.email ?? ""
//            self.uid = currentUser?.uid ?? ""
//        } else {
//            self.isLoggedIn = true
//            self.email = ""
//            self.uid = ""
//        }
//    }
    
    func resetUserPassword(_ email: String, resetCompletion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
    }
    
    func createAccount(_ email: String, _ password: String, _ confirmPW: String,
                       createCompletion: @escaping (Result<Bool, Error>) -> Void) {
        let valideEmail = isEmailValid(email)
        if valideEmail != true {
            createCompletion(.failure(CustomError.invalidEmail))
            return
        }
        
        let validPassword = isPasswordValid(password)
        if validPassword != true {
            createCompletion(.failure(CustomError.invalidPassword))
            return
        }
        
        let matched = passwordsMatch(password, confirmPW)
        if matched != true {
            createCompletion(.failure(CustomError.passwordNotMatch))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let eror = error {
                print(eror.localizedDescription )
                createCompletion(.failure(eror))
            }else{
                createCompletion(.success(true))
            }
         }
    }
    
    //MARK: - Validation checks
    func passwordsMatch(_ pw: String, _ confirmPW: String) -> Bool {
        return confirmPW == pw
    }
    
    func isEmpty(_ field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isEmailValid(_ email: String) -> Bool {
        if isEmpty(email) || email.count > 100 {
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        if isEmpty(password) {
            return false
        }
        
        let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,15}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func loadUserInfo() {
        localUserManager.reload { result in
            switch result {
            case .failure(_):
                print("something wrong reload user")
            case .success(_):
                print("user loaded!")
                self.currentUser = self.localUserManager.currentUser
                self.subjects = self.currentUser.subjects
            }
        }
    }
}
