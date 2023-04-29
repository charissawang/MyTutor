//
//  TimePickerView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/13/23.
//

import SwiftUI

struct TimePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var date: Date
    @Binding var startT: Date
    @Binding var endT: Date
    @Binding var timeSelected: Bool
    
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
                Text("Select Your Time")
                    .font(.title)
                DatePicker("Select Your Time",
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
            showAlert = true
            alertMessage = "Please select valid date and time!"
            return
        }
        
        timeSelected = true
        self.presentationMode.wrappedValue.dismiss()
    }
}
