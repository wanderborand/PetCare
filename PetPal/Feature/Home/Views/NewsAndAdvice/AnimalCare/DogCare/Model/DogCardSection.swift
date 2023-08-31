//
//  DogCardSection.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//

import SwiftUI

struct DogCardSection: Identifiable{
    var id = UUID()
    var title: String
    var caption: String
    var color: Color
    var image: Image
    
    static func == (vlhs: DogCardSection, vrhs: DogCardSection) -> Bool {
        return vlhs.id == vrhs.id
    }
    
}

var dogCardSection = [
    DogCardSection(title: "Food".localized, caption: "FoodSubTitle".localized, color: Color("blueLight"), image: Image(systemName: "fork.knife.circle.fill")),
    
    DogCardSection(title: "Cleaning".localized, caption: "CleaningSubTitle".localized, color: Color("pink"), image: Image(systemName: "wand.and.stars")),
    
    DogCardSection(title: "Grooming".localized, caption: "GroomingSubTitle".localized, color: Color("purpleMain"), image: Image(systemName: "scissors")),
    
    DogCardSection(title: "Vaccination".localized, caption: "VaccinationSubTitle".localized, color: Color("blueLight"), image: Image(systemName: "testtube.2")),
    
    DogCardSection(title: "Exercise".localized, caption: "ExerciseSubTitle".localized, color: Color("pink"), image: Image(systemName: "gamecontroller")),
    
    DogCardSection(title: "Health".localized, caption: "HealthSubTitle".localized, color: Color("purpleMain"), image: Image(systemName: "cross.case.fill")),
    
]

