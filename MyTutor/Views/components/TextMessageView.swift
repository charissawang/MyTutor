//
//  TextMessageView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/22/23.
//

import SwiftUI

struct TextMessageView: View {
    @State var content = "test"
    
    @State private var isShowingMessages = false
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    Section(header: Text("Send Text Message To: ")) {
                        HStack {
                            Text("xiaoru").foregroundColor(.gray)
                            Spacer()
                        }
                        
                        TextEditor(text: $content)
                            .frame(minHeight: 80)
                            .foregroundColor(.gray)
                        
                        Button("Show Messages") {
                            self.isShowingMessages = true
                        }
                        .sheet(isPresented: self.$isShowingMessages) {
                            MessageComposeView(recipients: ["+18178216802"], body: content) { messageSent in
                              print("MessageComposeView with message sent? \(messageSent)")
                            }
                        }
                    
                    }
                    
                }
                
                
            }
                
            
        }
    }
}

