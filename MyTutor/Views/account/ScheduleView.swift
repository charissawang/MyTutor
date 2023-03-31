//
//  ScheduleView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/28/23.
//

import SwiftUI

struct ScheduleView: View {
    @State var availableSchedules: [ScheduleInfo] = LocalUserManager.shared.currentUser.availableSchedules
    
    var body: some View {
        NavigationLink(destination: {
                ScheduleListView(schedules: $availableSchedules)
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

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
