//
//  Home.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct HomeView: View {
    //@ObservedObject var subjectViewModel = SubjectViewModel()
    // @ObservedObject var userViewModel = UserViewModel()
    
    var localUserManager = LocalUserManager.shared
    
    //@State var selectedItems: [String] = LocalUserManager.shared.currentUser.subjects
    @Binding var selectedItems: [String]
    @Binding var allSubjects: [String]
    @Binding var schedules: [String]
    
    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    Form {
                        Section("Choose your tutor subjects:", content: {
                            NavigationLink(destination: {
                                SubjectSelectPickerView(allItems: allSubjects, selectedItems: $selectedItems)
                                    .navigationTitle("Choose Your Subject")
                            }, label: {
                                HStack {
                                    Text("Select Subjects:")
                                        .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                                    Spacer()
                                    Image(systemName: "\($selectedItems.count).circle")
                                        .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                                        .font(.title2)
                                }
                            })
                        })
                        Section("My selected subjects are:", content: {
                            if selectedItems.count > 0 {
                                Text(selectedItems.joined(separator: "\n"))
                                    .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                            } else {
                                Text("Please select your subjects")
                                    .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                            }
                        })
                        
                        Section("My availables are:", content:{
                            ScheduleView(schedules: $schedules)
                        })
                    }
                    .navigationTitle("Dashboard")
//                    .onAppear() {
//                        //self.subjectViewModel.fetchAllSubjects()
//                        self.userViewModel.loadUserInfo()
//                    }
                }
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(selectedItems: [])
//    }
//}
