//
//  WelcomeView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct WelcomeView: View {
    let localData = LocalData()
    
    var body: some View {
        ZStack {
            VStack {
                Image("tutorials")
                    .resizable()
                    .backgroundStyle(.clear)
                    .aspectRatio(contentMode: .fit)
                Button {
                    localData.setStudentChoice()
                    buttonPressed();
                } label: {
                    Text("I am Student")
                        .background(Color.white)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.title)
                        .frame(width: 300)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 5)
                        )
                    
                }
                Button {
                    localData.setTutorChoice()
                    buttonPressed();
                } label: {
                    Text("I am Tutor")
                        .background(Color.white)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.title)
                        .frame(width: 300)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 5)
                        )
                }
                Button {
                    localData.setBothChoice()
                    buttonPressed();
                } label: {
                    Text("I am Both")
                        .background(Color.white)
                        .foregroundColor(.black)
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
            
        }
    }
    
    func buttonPressed() {
        let val = localData.getLocalData(AccountContants.USER_CHOICE)
        print ("user choice : \(val)")
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
