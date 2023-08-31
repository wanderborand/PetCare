//
//  ReminderCardListView.swift
//  PetPal
//
//  Created by Andrew on 29.05.2023.
//

import SwiftUI

struct ReminderCardListView: View {
    let title: String
    let reminders: [Reminder]
    let onDelete: (Reminder) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title)
            
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(reminders) { reminder in
                        ReminderCardView(reminder: reminder, onDelete: onDelete)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            if reminders.isEmpty {
                Text("Немає нагадувань")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
