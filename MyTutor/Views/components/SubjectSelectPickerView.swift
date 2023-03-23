//
//  SubjectSelectPickerView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/22/23.
//

import SwiftUI

struct SubjectSelectPickerView: View {
    var subjectViewModel = SubjectViewModel()
    // The list of items we want to show
    var allItems: [String]
 
    // Binding to the selected items we want to track
    @Binding var selectedItems: [String]
 
    var body: some View {
        Form {
            List {
                ForEach(allItems, id: \.self) { item in
                    Button(action: {
                        withAnimation {
                            if self.selectedItems.contains(item) {
                                // Previous comment: you may need to adapt this piece
                                self.selectedItems.removeAll(where: { $0 == item })
                            } else {
                                self.selectedItems.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(self.selectedItems.contains(item) ? 1.0 : 0.0)
                            Text(item)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .onDisappear() {
            print("onDisappear count: \($selectedItems.count)")
            subjectViewModel.createUserSubjects(selectedItems)
        }
    }
}

//struct SubjectSelectPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubjectSelectPickerView()
//    }
//}
