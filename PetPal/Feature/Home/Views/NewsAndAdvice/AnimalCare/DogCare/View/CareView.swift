//
//  DogCareView.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//

import SwiftUI

struct CareView: View {
    let breed: String
    
    @State private var selectedDogCard: DogCardSection? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                Text("ForBreed".localized + " " + breed)
                    .font(.title3)
                    .padding()
                
                VStack(spacing: 20) {
                    ForEach(dogCardSection) { section in
                        HCardDogCare(section: section)
                            .onTapGesture {
                                selectedDogCard = section
                            }
                    }
                }
                .padding(20)
                .fullScreenCover(item: $selectedDogCard) { section in
                    verticalDogCardDetailView(for: section)
                }
            }
            .padding()
        }
        .navigationTitle("Advice")
    }
    
    func verticalDogCardDetailView(for section: DogCardSection) -> some View {
        if section == dogCardSection[0] {
            return AnyView(FoodView())
        } else if section == dogCardSection[1] {
            return AnyView(CleaningView())
        } else if section == dogCardSection[2] {
            return AnyView(GroomingView())
        } else if section == dogCardSection[3] {
            return AnyView(VaccinationView())
        } else if section == dogCardSection[4] {
            return AnyView(ExerciseView())
        } else if section == dogCardSection[5] {
            return AnyView(HealthView())
        } else {
            return AnyView(EmptyView())
        }
    }
}


