//
//  ForgotPasswordView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/9/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var user = UserViewModel()
    @State private var valid = false
    @State private var showAlert = false
    @State private var errString: String?
    
    var body: some View {
        NavigationView {
            VStack {
                // Welcome
                Text("Request a password reset.")
                    .padding(.bottom, 50)
                
                VStack(alignment: .center) {
                    TextField("Enter email address", text: $user.email)
                        .foregroundColor(Color.primary).autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    Divider().background(Color.gray)
                }
                .padding(.horizontal,35)
                
                
                //Button
                ZStack{
                    Button {
                        resetPassword()
                    } label: {
                        HStack {
                            Text("Reset")
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
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Reset"),
                      message: Text(self.errString ?? "Success. Reset email sent. Check your email!"),
                      dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func resetPassword() {
        user.resetUserPassword(user.email) { result in
            switch result {
            case .failure(let error):
                self.errString = error.localizedDescription
            case .success( _):
                break
            }
            
            self.showAlert = true
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
