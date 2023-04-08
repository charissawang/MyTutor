//
//  AccountView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct AccountView: View {
    let localDataManager = LocalDataManager.shared
    let localUserManager = LocalUserManager.shared
    
    @State var isOn: Bool = true
    @State var displayName: String = ""
    @State var description: String = ""
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack{
                    //header
                    HStack (){
                        Text("Account").font(.system(size: 40).weight(.heavy)).padding()
                        Spacer()
                    }
                    
                    //tutor mode section
                    Section{
                        HStack {
                            Text("Tutor Mode").font(.system(size: 20))
                                .foregroundColor(Color.gray)
                                .padding([.leading])
                            Spacer()
                        }.padding()
                        HStack {
                            Button {
                                localDataManager.setStudentChoice()
                            } label: {
                                Text("Student")
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray)
                                    )
                            }
                            Button {
                                localDataManager.setStudentChoice()
                            } label: {
                                Text("Tutor")
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray)
                                    )
                                
                            }
                            Button {
                                localDataManager.setBothChoice()
                            } label: {
                                Text("Both")
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray)
                                    )
                                
                            }
                        }
                        .padding()
                        Divider().background(Color.gray)
                    }
                    
                    //Online section
                    Section {
                        Toggle(isOn: $isOn, label: {
                            Text("Online").foregroundColor(Color.gray).padding()
                        })
                        .toggleStyle(SwitchToggleStyle())
                        .tint(.green)
                        .padding()
                        Divider().background(Color.gray)
                    }
                    
                    //Name section
                    Section {
                        VStack {
                            Form {
                                Section("About me", content: {
                                    NavigationLink(destination: {
                                        AboutMeView(displayName: $displayName, description: $description)
                                            .navigationTitle("About me")
                                    }, label: {
                                        HStack {
                                            Text(displayName).foregroundColor(Color.black)
                                        }
                                    })
                                })
                            }
                        }
                    }
                    Spacer()
                    
                }.background(Color.gray.brightness(0.39))
            }.onAppear() {
                localUserManager.reload { result in
                    switch result {
                    case .failure(_):
                        print("reload user error in accountView")
                    case .success(_):
                        let name = localUserManager.currentUser.displayName
                        let email = localUserManager.currentUser.email
                        description = localUserManager.currentUser.description
                        displayName = name == "" ? email : name
                    }
                }
            
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
