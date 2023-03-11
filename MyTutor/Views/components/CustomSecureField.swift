//
//  CustomSecureField.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/9/23.
//

import SwiftUI

struct CustomSecureField: View {
    //MARK:- PROPERTIES
    var placeholder: Text
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    
    @Binding var password: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if password.isEmpty { placeholder.modifier(CustomTextM(fontName: fontName, fontSize: fontSize, fontColor: fontColor)) }
            SecureField("", text: $password, onCommit: commit)
                //.foregroundColor(.white)
        }
    }
}


//struct CustomSecureField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSecureField()
//    }
//}
