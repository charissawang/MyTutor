//
//  AccountView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack {
            Color .blue
            Image(systemName: "phone.fill")
                .foregroundColor(.white)
                .font(.system(size: 100))
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
