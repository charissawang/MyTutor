//
//  ContentView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack() {
//            if showWelcomeView() {
//                WelcomeView()
//            } else {
//                TabView {
//                    HomeView()
//                        .tabItem(){
//                            Image(systemName: "house.fill")
//                            Text("Home")
//                        }
//                    LessonsView()
//                        .tabItem(){
//                            Image(systemName: "book")
//                            Text("Lessons")
//                        }
//                    AccountView()
//                        .tabItem {
//                            Image(systemName: "person")
//                            Text("Account")
//                        }
//                }
//
//            }
            
            // LoginView()
            SubjectSelectionView()
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
