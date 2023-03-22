//
//  MultiSelectPickerView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/12/23.
//

import SwiftUI

struct MultiSelectPickerView: View {
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
    }
}

//struct MultiSelectPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        var items = ["1", "3"]
//        MultiSelectPickerView(selectedItems: items)
//    }
//}
