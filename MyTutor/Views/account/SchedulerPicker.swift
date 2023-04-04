//
//  SchedulerPicker.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/27/23.
//

import SwiftUI

struct SchedulerPicker: View {
    let localUserManager = LocalUserManager.shared
    
    @Binding var allSchedules: [String]
    @State private var date = Date.now
    @State private var startT = Date.now
    @State private var endT = Date.now
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                    .frame(maxHeight: 300)
                
                DatePicker("Start Time",
                           selection: $startT,
                           displayedComponents: [.hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                DatePicker("End Time",
                           selection: $endT,
                           displayedComponents: [.hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                
//                Text("Date is \(dateFormatter.string(from: date))")
//
//                Text("startT is \(timeFormatter.string(from: startT))")
//
//                Text("endT is \(timeFormatter.string(from: endT))")
            }
            Spacer()
            VStack {
                Button  {
                    saveSelection()
                } label: {
                    Text ("Save Your Selection")
                        .background(Color.white)
                } .alert(alertMessage, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
                //.frame(maxHeight: 120)
            }.padding()
            
            
        }.padding()
        
    }
    
    func saveSelection() {
        showAlert = false
        if DateUtils.validateDateTimeSelection(date: date, startTime: startT, endTime: endT) == false {
            alertMessage = "Please select valid date and time!"
            return
        }
        
        let newSchedule = dateFormatter.string(from: date)  + "\t" + timeFormatter.string(from: startT) + " - " + timeFormatter.string(from: endT)

        allSchedules.append(newSchedule)
        localUserManager.setAvailableSchedules(allSchedules)
        localUserManager.createOrUpdateUser()
        alertMessage = "Your selection is saved!"
        
        showAlert = true
    }
}

//struct SchedulerPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        SchedulerPicker()
//    }
//}
