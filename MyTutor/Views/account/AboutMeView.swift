//
//  NameFieldView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/24/23.
//

import SwiftUI

struct AboutMeView: View {
    let localUserManager = LocalUserManager.shared
    
    @State private var textHeight = CGFloat.zero
    @State var updated: Bool = false
    @Binding var displayName: String
    @Binding var description: String
    @Binding var phoneNumber: String
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Display Name")) {
                    TextField("display name", text: $displayName)
                }
                
                Section(header: Text("Phone Number")) {
                    TextField("Phone Number", text: $phoneNumber)
                }
                
                Section(header: Text("Something you want to know about me")) {
                    TextEditor(text: $description)
                        .frame(minHeight: 80)
                            .foregroundColor(.black)
                }
            }
        }.toolbar {
            ToolbarItem() {
                Button {
                    saveUserData()
                } label: {
                    HStack {
                        Text("Save")
                    }
                    .foregroundColor(.gray)
                }
            }
        }
    }
    
    func saveUserData() {
        localUserManager.setDisplayName(displayName)
        localUserManager.setDescription(description)
        localUserManager.setPhoneNumber(phoneNumber)
        
        localUserManager.createOrUpdateUser()
    }
}

//struct NameFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutMeView(displayName: "Xiaoru", description: "this is me!!!")
//    }
//}
