import Foundation
import SwiftUI
 
struct Note: Codable, Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var timeStamp: String
}
 
@MainActor class Notes: ObservableObject {
    private let NOTES_KEY = "cairocodersnoteskey"
    let date = Date()
    var notes: [Note] {
        didSet {
            saveData()
            objectWillChange.send()
        }
    }
     
    init() {
        // Load saved data
        if let data = UserDefaults.standard.data(forKey: NOTES_KEY) {
            if let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
                notes = decodedNotes
                return
            }
        }
        // Tutorial Note
        notes = [Note(title: "Test Note", content: "Tap add button. You can delete any note by swiping to the left!", timeStamp: date.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss"))]
    }
     
    func addNote(title: String, content: String) {
        let tempNote = Note(title: title, content: content, timeStamp: date.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss"))
        notes.insert(tempNote, at: 0)
        saveData()
    }
     
    // Save data
    private func saveData() {
        if let encodedNotes = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedNotes, forKey: NOTES_KEY)
        }
    }
}
 
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
