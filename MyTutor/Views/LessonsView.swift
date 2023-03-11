//
//  LessonsView.swift
//  MyTutor
//
//  Created by Charissa Wang on 3/8/23.
//

import SwiftUI

struct LessonsView: View {
    var body: some View {
        ZStack {
            Color .green
            Image(systemName: "phone.fill")
                .foregroundColor(.white)
                .font(.system(size: 100))
        }
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsView()
    }
}
