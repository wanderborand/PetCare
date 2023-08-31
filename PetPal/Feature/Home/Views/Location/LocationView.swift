//
//  LocationView.swift
//  PetPal
//
//  Created by Andrew on 29.05.2023.
//

import SwiftUI

struct LocationCards: Identifiable{
    var id = UUID().uuidString
    var name: String
    var asset: String
}

var locationCards = [
    LocationCards(name: "Coffee".localized, asset: "Coffee"),
    LocationCards(name: "Park".localized, asset: "Park2"),
    
    LocationCards(name: "Shelters".localized, asset: "Shelter"),
    LocationCards(name: "VetClinic".localized, asset: "VetClinic")
]


struct LocationView: View {
    @Environment(\.self) var env
    @State var txt = ""
    @State var selectedCard: LocationCards? = nil
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Location".localized)
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Button {
                            env.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                    }
                
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $txt)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(Capsule())
                    
                    HStack {
                        Text("Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {}) {
                            Text("ViewAll")
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.top, 25)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                        ForEach(locationCards) { card in
                            LocationCardView(card: card)
                                .onTapGesture {
                                    selectedCard = card
                                }
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
            
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        .sheet(item: $selectedCard) { card in
            getLocationFormView(for: card)
        }
    }
    
    @ViewBuilder
    private func getLocationFormView(for card: LocationCards) -> some View {
        switch card.id {
        case locationCards[0].id:
            CafeMapView()
        case locationCards[1].id:
            ParkMapView()
        case locationCards[2].id:
            SheltersMapView()
        case locationCards[3].id:
            VetClinicMapView()
        default:
            EmptyView()
        }
    }
}

struct LocationCardView: View {
    var card: LocationCards
    
    var body: some View {
        VStack {
            VStack {
                Image(card.asset)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .background(Color(card.asset))
                
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(card.name)
                            .font(.title3)
                        
                        //Text("\(card.numcards)")
                    }
                    .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(15)
            
            Spacer(minLength: 0)
        }
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
