//
//  TasksView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/22/23.
//

import SwiftUI

struct TasksView: View {
    let currentUser = LocalUserManager.shared.currentUser
    
    @ObservedObject var taskViewModel = TaskViewModel()
    
    @State var showTextView = false
    
    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    Form {
                        if taskViewModel.upcomingConfirmedTasks.count == 0 {
                            VStack {
                                HStack {
                                    Text("You don't have tasks at the moment")
                                        .bold()
                                        .foregroundColor(.gray)
                                        .padding()
                                    Spacer()
                                }
                            }
                        } else {
                            List {
                                ForEach(taskViewModel.upcomingConfirmedTasks, id: \.self) { task in
                                    VStack {
                                        HStack {
                                            Text(task.subject)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("from \(task.fromDisplayName)").foregroundColor(.gray)
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
                                                Text ("Send Remind Message")
                                                    .background(Color.white)
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            
                           
                        }
                        
                        if taskViewModel.pastConfirmedTasks.count > 0 {
                            NavigationLink(destination: {
                                PastTasksView(pastTasks: $taskViewModel.pastConfirmedTasks)
                                    .navigationTitle("My Past Tasks")
                            }, label: {
                                HStack {
                                    Text("My Past Tasks").foregroundColor(.gray)
                                        .bold()
                                        .padding()
                                }
                            })
                        }
                        
                       NavigationLink(destination: TextMessageView(),isActive: $showTextView) { EmptyView() }.opacity(0.0)
                    }
                    .navigationTitle("My Tasks")
                }
   
            }
        }
        .onAppear() {
            taskViewModel.loadTutorConfirmedTask(currentUser.email)
        }
    }
    
    func sendMessage(_ task: TaskInfo) {
        showTextView = true
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
