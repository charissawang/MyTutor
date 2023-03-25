//
//  AccountView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct AccountView: View {
    @State var isOn: Bool = true
    let localData = LocalData()
    
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
                                localData.setStudentChoice()
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
                                localData.setStudentChoice()
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
                                localData.setBothChoice()
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
                                Section("Display Name", content: {
                                    NavigationLink(destination: {
                                        HomeView()
                                            .navigationTitle("Display Name")
                                    }, label: {
                                        HStack {
                                            Text("Xiaoru").foregroundColor(Color.black)
                                        }
                                    })
                                })
                            }
                        }
                    }
                    Spacer()
                    
                }.background(Color.gray.brightness(0.39))
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
