//
//  LessonsView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct LessonsView: View {
    let currentUser = LocalUserManager.shared.currentUser
    
    @ObservedObject var taskViewModel = TaskViewModel()
    
    @State var showTextView = false
    
    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    Form {
                        if taskViewModel.upcomingConfirmedLessons.count == 0 {
                            VStack {
                                HStack {
                                    Text("You don't have lessons at the moment")
                                        .bold()
                                        .foregroundColor(.gray)
                                        .padding()
                                    Spacer()
                                }
                            }
                        } else {
                            List {
                                ForEach(taskViewModel.upcomingConfirmedLessons, id: \.self) { task in
                                    VStack {
                                        HStack {
                                            Text(task.subject)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("Tutor: \(task.fromDisplayName)").foregroundColor(.gray)
                                            Spacer()
                                        }
                                        Text("")
                                        HStack {
                                            Text("\(task.schedule)").foregroundColor(.gray)
                                            Spacer()
                                        }
                                        Text("")
                                        HStack {
                                            Button  {
                                                sendMessage(task)
                                            } label: {
                                                Text ("Send Message")
                                                    .background(Color.white)
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            
                           
                        }
                        
                        if taskViewModel.pastConfirmedLessons.count > 0 {
                            NavigationLink(destination: {
                                PastTasksView(pastTasks: $taskViewModel.pastConfirmedLessons)
                                    .navigationTitle("My Past Lessons")
                            }, label: {
                                HStack {
                                    Text("My Past Lessons").foregroundColor(.gray)
                                        .bold()
                                        .padding()
                                }
                            })
                        }
                        
                       NavigationLink(destination: TextMessageView(),isActive: $showTextView) { EmptyView() }.opacity(0.0)
                    }
                    .navigationTitle("My Lessions")
                }
   
            }
        }
        .onAppear() {
            taskViewModel.loadStudentConfirmedLessons(currentUser.email)
        }
    }
    
    func sendMessage(_ task: TaskInfo) {
        showTextView = true
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsView()
    }
}
