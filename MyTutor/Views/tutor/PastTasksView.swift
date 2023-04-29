//
//  PastTasksView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/22/23.
//

import SwiftUI

struct PastTasksView: View {
    @Binding var pastTasks: [TaskInfo]
    
    var body: some View {
        List {
            if pastTasks.count == 0 {
                VStack {
                    HStack {
                        Text("You don't have past tasks")
                            .bold()
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                }
            } else {
                ForEach(pastTasks, id: \.self) { task in
                    VStack {
                        HStack {
                            Text(task.subject)
                            Spacer()
                        }
                        HStack {
                            Text("from \(task.fromDisplayName)").foregroundColor(.gray)
                            Spacer()
                        }
                        Text("")
                        HStack {
                            Text("\(task.schedule)").foregroundColor(.gray)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
