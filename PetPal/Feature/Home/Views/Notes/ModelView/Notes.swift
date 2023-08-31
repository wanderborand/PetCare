//
//  Notes.swift
//  PetPal
//
//  Created by Andrew on 27.05.2023.
//

import SwiftUI

struct NotesFirst: View {
    @StateObject var notes = Notes()
    @State private var sheetIsShowing = false
    
    @Environment(\.self) var env
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Notes".localized)
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
                .padding()
                    
            NoteView()
                .sheet(isPresented: $sheetIsShowing) {
                    AddNew()
                }
                    
            Button {
                withAnimation {
                    self.sheetIsShowing.toggle()
                }
            } label: {
                Label {
                    Text("AddNote".localized)
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
        .environmentObject(notes)
    }
}

struct NotesFirst_Previews: PreviewProvider {
    static var previews: some View {
        NotesFirst()
    }
}
