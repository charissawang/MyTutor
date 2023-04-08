//
//  ScheduleListView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/28/23.
//

import SwiftUI

struct ScheduleListView: View {
    var localUserManager = LocalUserManager.shared
    
    @State private var isAddPressed: Bool = false
    @State private var editMode = EditMode.inactive
    //@State private var schedules: [ScheduleInfo] = (0..<5).map { ScheduleInfo(date: "Item #\($0)") }
    @Binding var schedules: [String]
    
    var body: some View {
        VStack {
            if schedules.count == 0 {
                Text(" Please click + button to add your time")
                    .bold()
                    .foregroundColor(.gray)
            }
            List {
                ForEach(schedules, id: \.self) { schedule in
                    Text(schedule)
                }
                .onDelete(perform: onDelete)
                //.onMove(perform: onMove)
            }
            .navigationBarTitle("Available Times")
            .navigationBarItems(leading: EditButton().padding(), trailing: addButton)
            .environment(\.editMode, $editMode)
        }
            
        NavigationLink(destination: SchedulerPicker(allSchedules: $schedules),isActive: $isAddPressed) { EmptyView() }
            .frame(width: 0, height: 0)
            .hidden()
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
        isAddPressed = true
        
    }
    
    private func onDelete(offsets: IndexSet) {
        for index in offsets{
            schedules.remove(at: index)
        }
        localUserManager.setAvailableSchedules(schedules)
        localUserManager.createOrUpdateUser()
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
