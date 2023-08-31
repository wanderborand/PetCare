//
//  Clothes.swift
//  PetPal
//
//  Created by Andrew on 01.06.2023.
//

import SwiftUI

struct Clothes: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var price: String
    var image: String
}

var clothes: [Clothes] = [
    .init(title: "FeedDog".localized, price: "150 ₴", image: "Feed1"),
    .init(title: "FeedCat".localized, price: "80 ₴", image: "CatFeed"),
    .init(title: "FeedFish".localized, price: "70 ₴", image: "FishFeed"),
]

