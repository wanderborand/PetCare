//
//  Cards.swift
//  PetPal
//
//  Created by Andrew on 25.05.2023.
//

import SwiftUI

struct Cards: Identifiable {
    var id = UUID()
    var title: String
    var subtitles: String
    //var caption: String
    var color: Color
    var image: Image
    
    static func == (lhs: Cards, rhs: Cards) -> Bool {
        return lhs.id == rhs.id
    }
}

var cards = [
    Cards(title: "RemindersTitle".localized, subtitles: "RemindersSubTitle".localized, color: Color("purpleMain"), image: Image("remind3")),
    
    Cards(title: "NotesTitle".localized, subtitles: "NotesSubTitle".localized, color: Color("yellowMain"), image: Image("notesPet")),
    
    Cards(title: "Activity".localized, subtitles: "ActivitySave".localized, color: Color("greenMain"), image: Image("activityPet")),
]
