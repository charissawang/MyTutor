//
//  ConfirmingTasksView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/20/23.
//

import SwiftUI

struct ConfirmingTasksView: View {
    let currentUser = LocalUserManager.shared.currentUser
    
    @ObservedObject var taskViewModel = TaskViewModel()
    
    @State var showingAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        VStack {
                if taskViewModel.requstedTasks.count == 0 {
                    HStack {
                        Text("You don't have requests at the moment")
                            .bold()
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                }
                List {
                    ForEach(taskViewModel.requstedTasks, id: \.self) { task in
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
                                    reply(task, "confirmed")
                                } label: {
                                    Text ("Confirm")
                                        .background(Color.white)
                                }
                                Text ("\t")
                                Button  {
                                    reply(task, "declined")
                                } label: {
                                    Text ("Decline")
                                        .background(Color.white)
                                }
                                Spacer()
                            }
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            
        }
        .onAppear() {
            taskViewModel.loadTutorRequestedTasks(currentUser.email)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    func reply(_ task: TaskInfo, _ status: String) {
        taskViewModel.updateTaskStatus(task, status) { result in
            switch result {
            case .failure(_):
                print("populateUserInfo error")
            case .success(_):
                showingAlert = true
                alertMessage = "\(status) message sent to \(task.from)"
                taskViewModel.loadTutorRequestedTasks(currentUser.email)
            }
        }
    }
}

struct ConfirmingTasksView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmingTasksView()
    }
}
