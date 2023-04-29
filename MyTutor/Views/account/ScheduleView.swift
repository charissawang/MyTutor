//
//  ScheduleView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/28/23.
//

import SwiftUI

struct ScheduleView: View {
    
    @Binding var schedules: [String]
    
    var body: some View {
        NavigationLink(destination: {
            ScheduleListView(schedules: $schedules)
            }, label: {
                HStack {
                    Text("Your available schedules:")
                        .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                    Spacer()
                    
                }
            }).onAppear() {
                
            }
    }
}
