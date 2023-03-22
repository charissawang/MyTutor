//
//  SubjectSelectionView.swift
//  MyTutor
//
//  Created by Xiaoru Zhao on 3/12/23.
//

import SwiftUI
import FirebaseAuth

struct SubjectSelectionView: View {
    @ObservedObject var subjectViewModel = SubjectViewModel()
    
    @State var selectedItems = ["1", "3"]
    
    //private var userViewModel = UserViewModel()
    private let currentUser = Auth.auth().currentUser
     
    var body: some View {
        NavigationView {
            Form {
                Section("Choose your tutor subjects:", content: {
                    NavigationLink(destination: {
                        MultiSelectPickerView(allItems: subjectViewModel.subjectItems, selectedItems: $selectedItems)
                            .navigationTitle("Choose Your Subject")
                    }, label: {
                        HStack {
                            Text("Select Subjects:")
                                .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                            Spacer()
                            Image(systemName: "\($selectedItems.count).circle")
                                .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                                .font(.title2)
                        }
                    })
                })
                Section("My selected subjects are:", content: {
                    Text(selectedItems.joined(separator: "\n"))
                        .foregroundColor(Color(red: 0.4192, green: 0.2358, blue: 0.3450))
                })
            }
            .navigationTitle("My Subjects")
            .onAppear() {
                self.subjectViewModel.fetchAllSubjects()
                self.subjectViewModel.fetchUserSubjects(currentUser?.uid ?? "")
                self.selectedItems = self.subjectViewModel.userSubjects
            }
            .onDisappear() {
                
            }
        }
    }
}

struct SubjectSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectSelectionView()
    }
}
