//
//  String+Extension.swift
//  PetPal
//
//  Created by Andrew on 21.05.2023.
//

import SwiftUI
import Foundation

extension String {
    var localized: String {
        NSLocalizedString(
            self,
            comment: "\(self) could not be found in Localizable.string"
        )
    }
}
