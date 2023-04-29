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
                    if (localDataManager.isTutor()) {
                        DashboardView(selectedItems: $userViewModel.currentUser.subjects,
                                 allSubjects: $subjectViewModel.subjectItems,
                                 schedules: $userViewModel.currentUser.availableSchedules)
                            .tabItem(){
                                Image(systemName: "globe")
                                Text("Dashboard")
                            }
                    }
                    if (localDataManager.isStudent()) {
                        HomeView(categories: $subjectViewModel.subjectCategories,
                                 subjectCategoryMap: $subjectViewModel.subjectCategoryMap)
                            .tabItem(){
                                Image(systemName: "house.fill")
                                Text("Home")
                            }
                        LessonsView()
                            .tabItem(){
                                Image(systemName: "book")
                                Text("Lessons")
                            }
                    }
                    if (localDataManager.isTutor()) {
                        TasksView()
                            .tabItem(){
                                Image(systemName: "calendar.badge.clock")
                                Text("Tasks")
                            }
                    }
                    AccountView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Account")
                        }
                }
                .onAppear() {
                    self.userViewModel.loadUserInfo()
                    self.subjectViewModel.fetchCategoryAndSubjects()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
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
