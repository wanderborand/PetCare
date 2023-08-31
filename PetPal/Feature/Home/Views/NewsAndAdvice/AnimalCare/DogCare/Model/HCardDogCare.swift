//
//  HCardDogCare.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//

import SwiftUI

struct HCardDogCare: View {
    var section: DogCardSection
    
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

struct HCardDogCare_Previews: PreviewProvider {
    static var previews: some View {
        HCardDogCare(section: dogCardSection[0])
    }
}
