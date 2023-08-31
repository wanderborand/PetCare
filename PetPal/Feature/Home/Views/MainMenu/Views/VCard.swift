//
//  VCard.swift
//  PetPal
//
//  Created by Andrew on 25.05.2023.
//

import SwiftUI

struct VCard: View {
    var cards: Cards
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(cards.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: 170, alignment: .leading)
                    .layoutPriority(1)
                Text(cards.subtitles)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(0.7)
            }
            
            cards.image
                .resizable()
                .frame(width: 180, height: 100)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    
        
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(width: 260, height: 310)
        .background(.linearGradient(colors: [cards.color, cards.color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: cards.color.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: cards.color.opacity(0.3), radius: 2, x: 0, y: 1)
        
        .overlay(
            Image(systemName: "plus.app")
                .font(.largeTitle)
                .foregroundColor(.whiteMain)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(20)
        )
    }
}

struct VCard_Previews: PreviewProvider {
    static var previews: some View {
        VCard(cards: cards[0])
    }
}
