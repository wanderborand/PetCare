//
//  ReminderListView.swift
//  PetPal
//
//  Created by Andrew on 27.05.2023.
//

import SwiftUI
import UserNotifications

struct Reminder: Identifiable, Codable {
    let id = UUID()
    var title: String
    var date: Date
    var color: String
    var isDeleted = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, date, color, isDeleted
    }
}

struct ReminderListView: View {
    @State private var selectedTab = 0
    @State private var isShowingCreateForm = false
    @State private var reminders: [Reminder] = []
    @Namespace var animation
    
    @Environment(\.self) var env
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Reminder".localized)
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button{
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
            
            HStack(spacing: 20) {
                Button(action: {
                    selectedTab = 0
                }) {
                    Text("Today".localized)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .scaleEffect(0.9)
                        .foregroundColor(selectedTab == 0 ? .whiteMain : .black)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background{
                            if selectedTab == 0 {
                                Capsule()
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                        .contentShape(Capsule())
                        .onTapGesture {
                            withAnimation{selectedTab = 0}
                        }
                        
                }
                
                Button(action: {
                    selectedTab = 1
                }) {
                    Text("Upcoming".localized)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .scaleEffect(0.9)
                        .foregroundColor(selectedTab == 1 ? .whiteMain : .black)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background{
                            if selectedTab == 1 {
                                Capsule()
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                        .contentShape(Capsule())
                        .onTapGesture {
                            withAnimation{selectedTab = 1}
                        }
                }
                
                Button(action: {
                    selectedTab = 2
                }) {
                    Text("TaskDone".localized)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .scaleEffect(0.9)
                        .foregroundColor(selectedTab == 2 ? .whiteMain : .black)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background{
                            if selectedTab == 2 {
                                Capsule()
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                        .contentShape(Capsule())
                        .onTapGesture {
                            withAnimation{selectedTab = 2}
                        }
                }
            }
            
            TabView(selection: $selectedTab) {
                ReminderCardListView(title: "", reminders: reminders.filter { !$0.isDeleted && Calendar.current.isDateInToday($0.date) }, onDelete: deleteReminder)
                    .tag(0)
                
                ReminderCardListView(title: "", reminders: reminders.filter { !$0.isDeleted && Calendar.current.isDateInTomorrow($0.date) }, onDelete: deleteReminder)
                    .tag(1)
                
                ReminderCardListView(title: "", reminders: reminders.filter { !$0.isDeleted && $0.date < Date() }, onDelete: deleteReminder)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            .overlay(alignment: .bottom) {
                Button {
                    isShowingCreateForm = true
                } label: {
                    Label {
                        Text("AddTask".localized)
                            .font(.callout)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "plus.app.fill")
                    }
                    .foregroundColor(.whiteMain)
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(.black, in: Capsule())
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                .background{
                    LinearGradient(colors: [
                        .whiteMain.opacity(0.85),
                        .whiteMain.opacity(0.4),
                        .whiteMain.opacity(0.7),
                        .whiteMain
                    ], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                }
            }
            
        }
        .padding()
        .sheet(isPresented: $isShowingCreateForm) {
            CreateReminderView { reminder in
                reminders.append(reminder)
                scheduleNotification(for: reminder)
                saveReminders()
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
            loadReminders()
        }
        .onDisappear {
            saveReminders()
        }
    }
    
    private func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = reminder.title
        content.body = "Reminder".localized
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: reminder.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: reminder.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            }
        }
    }
    
    private func deleteReminder(_ reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isDeleted = true
            saveReminders()
        }
    }
    
    private func saveReminders() {
        do {
            let data = try JSONEncoder().encode(reminders)
            UserDefaults.standard.set(data, forKey: "reminders")
        } catch {
            print("Failed to encode reminders: \(error)")
        }
    }
    
    private func loadReminders() {
        if let data = UserDefaults.standard.data(forKey: "reminders") {
            do {
                reminders = try JSONDecoder().decode([Reminder].self, from: data)
            } catch {
                print("Failed to decode reminders: \(error)")
            }
        }
    }
}


struct CreateReminderView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var selectedColor: String = "blueLight"
    @State private var date = Date()
    
    var onSave: (Reminder) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title".localized)) {
                    TextField("WriteTitle".localized, text: $title)
                }
                
                Section(header: Text("Color".localized)) {
                    HStack {
                        ColorCircle(color: Color("yellowMain"), isSelected: selectedColor == "yellowMain") {
                            selectedColor = "yellowMain"
                        }
                        
                        ColorCircle(color: Color("greenMain"), isSelected: selectedColor == "greenMain") {
                            selectedColor = "greenMain"
                        }
                        
                        ColorCircle(color: Color("blueLight"), isSelected: selectedColor == "blueLight") {
                            selectedColor = "blueLight"
                        }
                        
                        ColorCircle(color: Color("pink"), isSelected: selectedColor == "pink") {
                            selectedColor = "pink"
                        }
                    }
                }
                
                Section(header: Text("Date".localized)) {
                    DatePicker("SelectDate".localized, selection: $date, in: Date()...)
                        .datePickerStyle(WheelDatePickerStyle())
                }
            }
            .navigationTitle("EditTask".localized)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel".localized)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        let newReminder = Reminder(title: title, date: date, color: selectedColor)
                        onSave(newReminder)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save".localized)
                    }
                }
            }
        }
    }
}

struct ReminderCardListView: View {
    let title: String
    let reminders: [Reminder]
    let onDelete: (Reminder) -> Void
    
    // Формат дати та часу для відображення без "Eastern European Summer Time"
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy HH:mm"
            return formatter
    }()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title)
            
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(reminders) { reminder in
                        ReminderCardView(reminder: reminder, onDelete: onDelete, dateFormatter: dateFormatter)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            if reminders.isEmpty {
                Text("NoReminders".localized)
                    .foregroundColor(.gray)
                    .padding(.bottom, 80)
            }
                
        }
        .padding()
    }
}

struct ReminderCardView: View {
    let reminder: Reminder
    let onDelete: (Reminder) -> Void
    @State private var isMenuVisible = false
    
    let dateFormatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.whiteMain)
                    .font(.title3)
                
                Text(reminder.title)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .padding(.top, 16)
            .padding(.bottom, 16)
            
            HStack{
                Image(systemName: "calendar")
                    .foregroundColor(.whiteMain)
                
                Text(dateFormatter.string(from: reminder.date))
                    .font(.subheadline)
            }
            
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity) // Set the frame to occupy the full width
        .background(Color(reminder.color))
        .foregroundColor(.white)
        .cornerRadius(12)
        .onTapGesture {
            withAnimation {
                isMenuVisible.toggle()
            }
        }
        .contextMenu(menuItems: {
            Button(action: {
                onDelete(reminder)
            }) {
                Label("Remove".localized, systemImage: "trash")
            }
        })
    }
}

struct ColorCircle: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 30, height: 30)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: isSelected ? 3 : 0)
                )
        }
        .onTapGesture {
            action()
        }
    }
}

struct ReminderListView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView()
    }
}

