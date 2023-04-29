//
//  Home.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct HomeView: View {
    var localUserManager = LocalUserManager.shared
    var localTaskManager = LocalTaskManager.shared
    
    @ObservedObject var studentHomeViewModel = StudentHomeViewModel()
    
    @Binding var categories: [String]
    @Binding var subjectCategoryMap: [String: [String]]
    
    @State private var date = Date.now
    @State private var startT = Date.now
    @State private var endT = Date.now
    @State private var timeSelected: Bool = false
    
    @State private var selectedCategory = ""
    @State private var selectedSubject: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    Form {
                        Section("What subjects you need help with?", content: {
                            Picker("Categories", selection: $selectedCategory) {
                                Text("Select Your Category")
                                ForEach(categories, id: \.self) {
                                    Text($0)
                                }
                            }
                            // Text("You selected: \(selectedCategory)")
                        })
                        
                        if !selectedCategory.isEmpty {
                            Section("", content: {
                                Picker("Subjects", selection: $selectedSubject) {
                                    Text("Select Your Subject ")
                                    if let subjects = subjectCategoryMap[selectedCategory] {
                                        ForEach(subjects, id: \.self) {
                                            Text($0)
                                        }
                                    }
                                }
                            })
                        }

                        if !selectedSubject.isEmpty {
                            Section("", content: {
                                NavigationLink(destination: {
                                    TimePickerView(date: $date, startT: $startT, endT: $endT, timeSelected: $timeSelected)
                                }, label: {
                                    HStack {
                                        Text("Select Your Time:")
                                            .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                                    }
                                })
                            })
                        }

                        if timeSelected {
                            Section("", content: {
                                HStack {
                                    Image(systemName: "checkmark")
                                        .opacity(1.0)
                                    Text(AccountContants.DATE_FORMATTER.string(from: date)  + "\t"
                                         + AccountContants.TIME_FORMATTER.string(from: startT) + " - "
                                         + AccountContants.TIME_FORMATTER.string(from: endT))
                                }
                            })
                        }
                        
                        if studentHomeViewModel.tutorLoaded && timeSelected {
                            Section("Availabe Tutors", content: {
                                List {
                                    if studentHomeViewModel.availableTutors.count > 0 {
                                        ForEach(studentHomeViewModel.availableTutors, id: \.self) { tutor in
                                            VStack {
                                                HStack {
                                                    Text(tutor.displayName)
                                                    Spacer()
                                                }
                                                Text("")
                                                Text(tutor.description).foregroundColor(.gray)
                                                
                                                HStack {
                                                    
                                                    Button  {
                                                        sendRequest(tutor)
                                                    } label: {
                                                        Text ("Request")
                                                            .background(Color.white)
                                                    }
                                                    Spacer()
                                                }
                                                
                                            }
                                        }
                                    }
                                    
                                }
                                
                            })
                        }
                    
                        
                        if timeSelected == true {
                            VStack {
                                Button  {
                                    search()
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text ("Find Available Tutors")
                                            .background(Color.white)
                                        Spacer()
                                    }
                                }
                            }
                        }
                       
                    }
                }
                
                Spacer()
            }
            
            if studentHomeViewModel.isLoadingTutors {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(2.0, anchor: .center)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    func search() {
        let schedule = AccountContants.DATE_FORMATTER.string(from: date)  + "\t"
        + AccountContants.TIME_FORMATTER.string(from: startT) + " - "
        + AccountContants.TIME_FORMATTER.string(from: endT)
        
        studentHomeViewModel.findTuturs(selectedSubject, schedule)
    }
    
    func sendRequest(_ user: UserInfo) {
        let currentUser = localUserManager.currentUser
        
        let schedule = AccountContants.DATE_FORMATTER.string(from: date)  + "\t"
             + AccountContants.TIME_FORMATTER.string(from: startT) + " - "
             + AccountContants.TIME_FORMATTER.string(from: endT)
        
        localTaskManager.createTask(currentUser, user, selectedSubject, schedule)
        
        showingAlert = true
        alertMessage = "Your request is sent to \(user.email) "
        selectedCategory = ""
        selectedSubject = ""
        timeSelected = false
    }
}
