//
//  CardSection.swift
//  PetPal
//
//  Created by Andrew on 25.05.2023.
//

import SwiftUI

struct CardSection: Identifiable{
    var id = UUID()
    var title: String
    var caption: String
    var color: Color
    var image: Image
    
    static func == (vlhs: CardSection, vrhs: CardSection) -> Bool {
        return vlhs.id == vrhs.id
    }
    
}

var cardSection = [
    CardSection(title: "LocationTitle".localized, caption: "LocationSubTitle".localized, color: Color("blueLight"), image: Image(systemName: "location.magnifyingglass")),

    CardSection(title: "NewsAndTipsTitle".localized, caption: "NewsAndTipsSubTitle".localized, color: Color("pink"), image: Image(systemName: "newspaper.circle"))
]
