//
//  Home.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color .red
            Image(systemName: "phone.fill")
                .foregroundColor(.white)
                .font(.system(size: 100))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
