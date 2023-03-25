//
//  ContentView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct ContentView: View {
    var fireBaseManager = FirebaseManager.shared
    var localUserManager = LocalUserManager.shared
    
    var body: some View {
        HStack() {
            if showWelcomeView() {
                WelcomeView()
            } else if (fireBaseManager.isUserLoggedIn() == true) {
                LoginView()
            } else {
                TabView {
                    HomeView()
                        .tabItem(){
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    LessonsView()
                        .tabItem(){
                            Image(systemName: "book")
                            Text("Lessons")
                        }
                    AccountView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Account")
                        }
                }
            }
            
            // SubjectSelectionView(selectedItems: ["1", "2"])
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
    
    func showWelcomeView() -> Bool {
        let localData = LocalData()
        //localData.clearUserChoice()
        
        let userChoice = localData.getLocalData(AccountContants.USER_CHOICE)
        
        print("userChoice: \(userChoice ?? "")")
        if userChoice == nil {
            return true
        }
        
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
