//
//  CustomindicatorView.swift
//  PetPal
//
//  Created by Andrew on 20.05.2023.
//

import SwiftUI

struct CustomindicatorView: View {
    var totalPages: Int
    var currentPage: Int
    var activeTint: Color = .black
    var inActiveTint: Color = .gray.opacity(0.5)
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) {
                Circle()
                    .fill(currentPage == $0 ?  activeTint : inActiveTint)
                    .frame(width: 4, height: 4)
                
            }
        }
    }
}

struct CustomindicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
