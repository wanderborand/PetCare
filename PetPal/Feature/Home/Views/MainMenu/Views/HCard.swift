//
//  HCard.swift
//  PetPal
//
//  Created by Andrew on 25.05.2023.
//

import SwiftUI

struct HCard: View {
    var section: CardSection
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(section.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(section.caption)
                    .font(.body)
                
            }
            Divider()
            section.image
                .font(.title)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(section.color)
        .foregroundColor(.white)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct HCard_Previews: PreviewProvider {
    static var previews: some View {
        HCard(section: cardSection[0])
    }
}
