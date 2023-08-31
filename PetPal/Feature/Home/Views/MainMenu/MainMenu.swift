//
//  MainMenu.swift
//  PetPal
//
//  Created by Andrew on 24.05.2023.
//

import SwiftUI

struct MainMenu: View {
    
    @State private var selectedCard: Cards? = nil
    @State private var selectedVerticalCard: CardSection? = nil
    
    var body: some View {
        ZStack {
            ScrollView {
                Color("whiteMain").ignoresSafeArea()
                content
            }
        }
        .padding(.bottom, 80)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("HealthCalendar".localized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.verydarkblue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(cards) { cards in
                        GeometryReader{ geometry in
                            VCard(cards: cards)
                                .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 20) / -20), axis: (x: 0 , y: 10, z: 0))
                        }
                        .frame(width: 260, height: 310)
                        .onTapGesture {
                            selectedCard = cards
                        }
                       
                    }
                }
                .padding(20)
                .padding(.bottom, 10)
            }
            
            .fullScreenCover(item: $selectedCard) { card in
                cardDetailView(for: card)
            }
            
            Text("Additionally".localized)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.verydarkblue)
                .padding(.horizontal, 20)
                
            VStack(spacing: 20) {
                ForEach(cardSection) { section in
                    HCard(section: section)
                        .onTapGesture {
                            selectedVerticalCard = section
                        }
                }
            }
            .padding(20)
            .fullScreenCover(item: $selectedVerticalCard) { section in
                verticalCardDetailView(for: section)
            }
                
        }
    }
    
    func cardDetailView(for card: Cards) -> some View {
            if card == cards[0] {
                return AnyView(ReminderListView())
            } else if card == cards[1] {
                return AnyView(NotesFirst())
            } else if card == cards[2] {
                return AnyView(PetActivityView())
            } else {
                return AnyView(EmptyView())
            }
        }
    
    
    func verticalCardDetailView(for section: CardSection) -> some View {
        if section == cardSection[0] {
            return AnyView(LocationView())
        } else if section == cardSection[1] {
            return AnyView(NewsAndAdviceView())
        } else {
            return AnyView(EmptyView())
        }
    }
    
    
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}

