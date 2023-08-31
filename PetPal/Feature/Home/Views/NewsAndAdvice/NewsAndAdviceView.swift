//
//  NewsAndAdviceView.swift
//  PetPal
//
//  Created by Andrew on 30.05.2023.
//

import SwiftUI

struct NewsAndAdviceCards: Identifiable {
    var id = UUID().uuidString
    var name: String
    var asset: String
}

var newsAndAdviceCards = [
    NewsAndAdviceCards(name: "AnimalInfo".localized, asset: "NatNews"),
    NewsAndAdviceCards(name: "CareRecommendations".localized, asset: "PetCare"),
    NewsAndAdviceCards(name: "HelpAnimals".localized, asset: "Shelter")
]

struct NewsAndAdviceView: View {
    @Environment(\.self) var env
    @State var txt = ""
    @State var selectedNewsCard: NewsAndAdviceCards? = nil
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("NewsAnd".localized)
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
                    ForEach(newsAndAdviceCards) { card in
                        NewsAndAdviceCardView(card: card)
                            .onTapGesture {
                                selectedNewsCard = card
                            }
                            .padding(.bottom, 20)
                    }
                }
                .padding()
            }
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        .sheet(item: $selectedNewsCard) { card in
            getNewsFormView(for: card)
        }
    }
    
    @ViewBuilder
    private func getNewsFormView(for card: NewsAndAdviceCards) -> some View {
        switch card.id {
        case newsAndAdviceCards[0].id:
            AnimalInfoView()
        case newsAndAdviceCards[1].id:
            PetCareView()
        case newsAndAdviceCards[2].id:
            SheltersMapView()
        default:
            EmptyView()
        }
    }
}

struct NewsAndAdviceCardView: View {
    var card: NewsAndAdviceCards
    
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
                            .font(.title2.bold())
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

struct NewsAndAdviceView_Previews: PreviewProvider {
    static var previews: some View {
        NewsAndAdviceView()
    }
}
