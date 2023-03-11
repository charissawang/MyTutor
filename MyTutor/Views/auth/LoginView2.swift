//
//  LoginView2.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/9/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView2: View {
    @State private var username = ""
    @State private var password = ""

    @State private var valid = false
    @State private var showingInvalidAlert = false

    var body: some View {
        NavigationView {
            VStack {
                // Welcome
                VStack(spacing:15){
                    Text("Hello There")
                        .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 34, fontColor: Color.pink))
                    Text("Please sign in to continue.")
                        .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 18, fontColor: Color.primary))
                }
                .padding(.top,45)
                Spacer()
                
                VStack(spacing: 15){
                    VStack(alignment: .center, spacing: 30){
                        VStack(alignment: .center) {
                            CustomTextfield(placeholder:
                                                Text("Username"),
                                            fontName: "RobotoSlab-Light",
                                            fontSize: 18,
                                            fontColor: Color.gray,
                                            username: $username)
                            Divider()
                                .background(Color.gray)
                        }
                        VStack(alignment: .center) {
                            CustomSecureField(placeholder:
                                                Text("Password"),
                                              fontName: "RobotoSlab-Light",
                                              fontSize: 18,
                                              fontColor: Color.gray,
                                              password: $password)
                            Divider()
                                .background(Color.gray)
                        }
                    }
                    HStack{
                        Spacer()
                        Button(action: {}){
                            Text("Forgot Pass?")
                                .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 14, fontColor: Color.gray))
                        }
                    }
                }
                .padding(.horizontal,35)
                
                //Button
                ZStack{
                    Button {
                        login()
                    } label: {
                        Text("Sign In")
                            .background(Color.white)
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                            .font(.title)
                            .frame(width: 300)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 5)
                            )
                        
                    }
                    
                }
                .padding(.top,35)
                Spacer()
                //SignUp
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Sign up, if you’re new!")
                        .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 18, fontColor: Color.primary))
                }
                .padding(.bottom,30)
                
//                TextField("username", text: $username)
//                    .frame(width: 300, height: 50)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                SecureField("password", text: $password)
//                    .frame(width: 300, height: 50)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                Button {
////                    valid = login(username: username, password: password)
////                    if valid == false {
////                        showingInvalidAlert.toggle()
////                    }
//                    login()
//                } label: {
//                    HStack {
//                            Text("Login")
//                            Image(systemName: "chevron.right")
//                        }
//                }
//                .frame(width: 300, height: 20)
//                .padding(.vertical ,10)
//                .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(lineWidth: 2.0)
//                    )

                NavigationLink(destination: HomeView(),isActive: $valid) { //<- This will take it to rest
                        EmptyView()
                }

            }
            .navigationBarHidden(true)
            .alert(isPresented: $showingInvalidAlert) {
                Alert(title: Text("Invalid"), message: Text("Invalid username or password"), dismissButton: .default(Text("Ok")))
            }
        }
    }

//    func login(username: String, password: String) -> Bool {
//        // In here your check to see if username/password are valid
//        if username == "danny", password == "password" {
//            return true
//        }
//
//        return false
//    }
    func login() {
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                valid = false
                showingInvalidAlert.toggle()
            } else {
                print("success1")
                valid = true
                //HomeView()
            }
        }
    }
}

struct LoginView2_Previews: PreviewProvider {
    static var previews: some View {
        LoginView2()
    }
}
