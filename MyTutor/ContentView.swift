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
    var localDataManager = LocalDataManager.shared
    
    var body: some View {
        HStack() {
            if showWelcomeView() {
                WelcomeView()
            } else if (fireBaseManager.isUserLoggedIn() == false) {
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
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
        //SchedulerPicker()
    }
    
    func showWelcomeView() -> Bool {
        let userChoice = localDataManager.getLocalData(AccountContants.USER_CHOICE)
        
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
