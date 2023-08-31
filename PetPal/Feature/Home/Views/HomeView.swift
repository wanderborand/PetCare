//
//  HomeView.swift
//  PetPal
//
//  Created by Andrew on 20.05.2023.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = "house"
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        ZStack(alignment: .bottom, content: {
            TabView(selection: $selectedTab) {
                MainMenu()
                    .tag("house")
                ChatView()
                    .tag("message")
                Shop()
                    .tag("cart")
                ProfileView()
                    .tag("person")
            }
            CustomTabBar(selectedTab: $selectedTab)
                .ignoresSafeArea()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(SessionServiceImpl())
        }
    }
}
