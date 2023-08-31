//
//  TabViewTwo.swift
//  PetPal
//
//  Created by Andrew on 24.05.2023.
//

import SwiftUI

struct ReminderEditorView: View {
    @State private var title = ""
    @State private var date = Date()
    @State private var time = Date()
    @State private var repeatOptions = ["None", "Daily", "Weekly", "Monthly"]
    @State private var selectedRepeatOption = "None"
    
    var body: some View {
        Form {
            Section(header: Text("Reminder Details")) {
                TextField("Title", text: $title)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                
                Picker("Repeat", selection: $selectedRepeatOption) {
                    ForEach(repeatOptions, id: \.self) { option in
                        Text(option)
                    }
                }
            }
            
            Section {
                Button(action: saveReminder) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationTitle("New Reminder")
    }
    
    func saveReminder() {
        // Perform your save logic here
        print("Reminder saved:")
        print("Title: \(title)")
        print("Date: \(date)")
        print("Time: \(time)")
        print("Repeat: \(selectedRepeatOption)")
    }
}

struct ReminderView: View {
    var body: some View {
        NavigationView {
            ReminderEditorView()
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

