//
//  Tab.swift
//  PetPal
//
//  Created by Andrew on 23.05.2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case services = "Services"
    case partners = "Partners"
    case activity = "Activity"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .services:
            return "message"
        case .partners:
            return "hand.raised"
        case .activity:
            return "person"
        }
    }
    
    //Return current Tab Index
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
