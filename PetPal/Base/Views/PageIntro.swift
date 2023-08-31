//
//  PageIntro.swift
//  PetPal
//
//  Created by Andrew on 20.05.2023.
//

import SwiftUI

struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var title: String
    var subTitle: String
    var displaysAction: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "welcomePage_1", title: "welcomeTitlePageOne".localized, subTitle: "welcomeSubTitlePageOne".localized),
    .init(introAssetImage: "welcomePage_2", title: "welcomeTitlePageTwo".localized, subTitle: "welcomeSubTitlePageTwo".localized),
    .init(introAssetImage: "welcomePage_3", title: "welcomeTitlePageThree".localized, subTitle: "welcomeSubTitlePageThree".localized, displaysAction: true),
]
