//
//  ScheduleListView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/28/23.
//

import SwiftUI

struct ScheduleListView: View {
    @State private var editMode = EditMode.inactive
    //@State private var schedules: [ScheduleInfo] = (0..<5).map { ScheduleInfo(date: "Item #\($0)") }
    @Binding var schedules: [ScheduleInfo]
    
    var body: some View {
        List {
            ForEach(schedules) { schedule in
                Text(schedule.date)
            }
            .onDelete(perform: onDelete)
            //.onMove(perform: onMove)
        }
        .navigationBarTitle("Available Times")
        .navigationBarItems(leading: EditButton().padding(), trailing: addButton)
        .environment(\.editMode, $editMode)
    }
    private var addButton: some View {
            switch editMode {
            case .inactive:
                return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
        }
    
    func onAdd() {
            print ("on Add")
    }
    
    private func onDelete(offsets: IndexSet) {
        print ("on delete")
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        print ("on delete")
        }
}



//struct ScheduleListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleListView()
//    }
//}
