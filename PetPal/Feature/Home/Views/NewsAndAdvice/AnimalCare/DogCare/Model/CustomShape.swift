//
//  CustomShape.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//

import SwiftUI

struct CustomShape: Shape {
    
    var cornes: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: cornes, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}


