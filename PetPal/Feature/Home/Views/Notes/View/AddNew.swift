//
//  AddNew.swift
//  PetPal
//
//  Created by Andrew on 27.05.2023.
//

import SwiftUI
 
struct AddNew: View {
    @State private var title = ""
    @State private var content = ""
    @EnvironmentObject var notes: Notes
    @Environment(\.dismiss) var dismiss
     
    var body: some View {
        Form {
            Section {
                TextField("NoteTitle".localized, text: $title)
                ZStack {
                    TextEditor(text: $content)
                        .frame(height: 200)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(content.count)/120")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button("AddNote".localized) {
                        notes.addNote(title: title, content: content)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
 
struct AddNew_Previews: PreviewProvider {
    static var previews: some View {
        AddNew()
            .environmentObject(Notes())
    }
}
