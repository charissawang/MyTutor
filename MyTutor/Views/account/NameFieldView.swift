//
//  NameFieldView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/24/23.
//

import SwiftUI

struct NameFieldView: View {
    @State var name: String = "Xiaoru"
    
    var body: some View {
        NavigationView {
            Form {
                Section("Display Name:", content: {
                    NavigationLink(destination: {
                        HomeView()
                            .navigationTitle("Display Name")
                    }, label: {
                        HStack {
                            Text(name)
                                .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                        }
                    })
                })
            }
        }
    }
}

struct NameFieldView_Previews: PreviewProvider {
    static var previews: some View {
        NameFieldView()
    }
}
