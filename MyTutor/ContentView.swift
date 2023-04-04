//
//  ContentView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var subjectViewModel = SubjectViewModel()
    
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
                    HomeView(selectedItems: $userViewModel.currentUser.subjects, allSubjects: $subjectViewModel.subjectItems)
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
                .onAppear() {
                    self.subjectViewModel.fetchAllSubjects()
                    self.userViewModel.loadUserInfo()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
        //SchedulerPicker()
    }
    
    func showWelcomeView() -> Bool {
        // localDataManager.clearUserChoice()
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
