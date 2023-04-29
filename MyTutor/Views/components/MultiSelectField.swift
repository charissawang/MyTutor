//
//  MultiSelectField.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 4/12/23.
//

import SwiftUI

struct MultiSelectField: View {
    var options: [String]
    @State var selectedOptions: [String] = ["Option 2"]
    
    var body: some View {
        VStack {
            //Text("Selected options: \(selectedOptions.joined(separator: ", "))")
            
            Picker(selection: $selectedOptions, label: Text("Options")) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag([option])
                }
            }.pickerStyle(.automatic)
        }
    }
}

