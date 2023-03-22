//
//  SignupView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/9/23.
//

import SwiftUI

struct SignupView: View {
    @State private var user = UserViewModel()

    @State private var valid = false
    @State private var showingAlert = false
    @State private var errString: String?
    
    var body: some View {
        NavigationView {
            VStack {
                // Welcome
                VStack(spacing:15){
                    Text("Create Account")
                        .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 18, fontColor: Color.primary))
                }
                .padding(45)
                Spacer()
                
                VStack(spacing: 15){
                    VStack(alignment: .center, spacing: 30){
                        VStack(alignment: .center) {
                            TextField("email", text: $user.email)
                                .foregroundColor(Color.primary).autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                            Divider().background(Color.gray)
                        }
                        VStack(alignment: .center) {
                            SecureField("Password", text: $user.password)
                            Divider().background(Color.gray)
                        }
                        VStack(alignment: .center) {
                            SecureField("Confirm Password", text: $user.confirmPassword)
                            Divider().background(Color.gray)
                        }
                    }
                   
                }
                .padding(.horizontal,35)
                
                //Button
                ZStack{
                    Button {
                        //login()
                        signUp()
                    } label: {
                        HStack {
                            Text("Register")
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
                
                NavigationLink(destination: HomeView(),isActive: $valid) { EmptyView() }

            }
            .navigationBarHidden(true)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Create Account"),
                      message: Text(self.errString ?? ""),
                      dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func signUp() {
        user.createAccount(user.email, user.password, user.confirmPassword) { result in
            switch result {
            case .failure(let error):
                self.errString = error.localizedDescription
                valid = false
                self.showingAlert = true
            case .success(_):
                valid = true
            }
            
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
