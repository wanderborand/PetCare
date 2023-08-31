//
//  Tab.swift
//  PetPal
//
//  Created by Andrew on 01.06.2023.
//

import SwiftUI

struct Tab: Identifiable {
    var id: String = UUID().uuidString
    var tabImage: String
    var tabName: String
    var tabOffset: CGSize
}

var tabs: [Tab] = [
    .init(tabImage: "PetFeedTab", tabName: "150 ₴", tabOffset: CGSize(width: 0, height: -40)),
    .init(tabImage: "PetPiilsTab", tabName: "500 ₴", tabOffset: CGSize(width: 0, height: -38)),
    .init(tabImage: "PetToysTab", tabName: "300 ₴", tabOffset: CGSize(width: 0, height: -25)),
    .init(tabImage: "PetClothesTab", tabName: "1200 ₴", tabOffset: CGSize(width: -12, height: 28)),
]
