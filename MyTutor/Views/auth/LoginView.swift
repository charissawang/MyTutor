//
//  LoginView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/9/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    var user = UserViewModel()

    @State var email = ""
    @State var password = ""
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
                            TextField("email", text: $email)
                                .foregroundColor(Color.primary).autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                            Divider().background(Color.gray)
                        }
                        VStack(alignment: .center) {
                            SecureField("Password", text: $password)
                            Divider().background(Color.gray)
                        }
                    }
                    HStack{
                        Spacer()
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot Pass?")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal,35)
                
                //Button
                ZStack{
                    Button {
                        login()
                    } label: {
                        HStack {
                            Text("Login")
                            Image(systemName: "chevron.right")
                        }
                        .background(Color.white)
                        .foregroundColor(.gray)
                       
                        .font(.title)
                        .frame(width: 300,  height: 20)
                        .padding(.vertical ,10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 2.0)
                        )
                    }
                    
                }
                .padding(.top,35)
                Spacer()
                
                //SignUp
                NavigationLink(destination: SignupView()) {
                    Text("Sign up, if you’re new!")
                        .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 18, fontColor: Color.primary))
                        .padding(.bottom,30)
                }
                
                NavigationLink(destination: HomeView(),isActive: $valid) { EmptyView()
                }

            }
            .navigationBarHidden(true)
            .alert(isPresented: $showingInvalidAlert) {
                Alert(title: Text("Invalid"), message: Text("Invalid username or password"), dismissButton: .default(Text("Ok")))
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                valid = false
                showingInvalidAlert.toggle()
            } else {
                print("success1")
                valid = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
