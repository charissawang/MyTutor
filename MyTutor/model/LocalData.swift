//
//  LocalData.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import Foundation

struct LocalData {
    let defaults = UserDefaults.standard
    
    func setLocalData(_ key: String, _ value: String?) {
        defaults.set(value, forKey: key)
    }
    
    func getLocalData(_ key: String) -> String? {
        let defaults = UserDefaults.standard
        if let value = defaults.string(forKey: key) {
            return value
        }
        
        return nil
    }
    
    func clearUserChoice() {
        setLocalData(AccountContants.USER_CHOICE, nil)
    }
    
    func setStudentChoice() {
        setLocalData(AccountContants.USER_CHOICE, AccountContants.STUDENT_TYPE)
    }
    
    func setTutorChoice() {
        setLocalData(AccountContants.USER_CHOICE, AccountContants.TUTOR_TYPE)
    }
    
    func setBothChoice() {
        setLocalData(AccountContants.USER_CHOICE, AccountContants.STUDENT_AND_TUTOR_TYPE)
    }
}
