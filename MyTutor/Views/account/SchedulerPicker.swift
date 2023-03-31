//
//  SchedulerPicker.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/27/23.
//

import SwiftUI

struct SchedulerPicker: View {
    @State private var date = Date.now
    @State private var startT = Date.now
    @State private var endT = Date.now
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }

    
    var body: some View {
        VStack {
            VStack {
                Text("Your available date and time")
                    .font(.title)
                DatePicker("Your available date and time",
                           selection: $date,
                           displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxHeight: 350)
                
                DatePicker("Start Time",
                           selection: $startT,
                           displayedComponents: [.hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                DatePicker("End Time",
                           selection: $endT,
                           displayedComponents: [.hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                
    //            Text("Date is \(dateFormatter.string(from: date))")
    //
    //            Text("startT is \(timeFormatter.string(from: startT))")
    //
    //            Text("endT is \(timeFormatter.string(from: endT))")
            }
            Spacer()
            VStack {
                Form {
                    Button  {
                                
                    } label: {
                        Text ("Save Your Selection")
                    }
                }
                .frame(maxHeight: 120)
            }
            
            
        }.padding()
    }
}

struct SchedulerPicker_Previews: PreviewProvider {
    static var previews: some View {
        SchedulerPicker()
    }
}
