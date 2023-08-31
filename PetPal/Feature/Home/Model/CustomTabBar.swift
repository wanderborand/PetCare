//
//  CustomTabBar.swift
//  PetPal
//
//  Created by Andrew on 23.05.2023.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    @State var tabPoints: [CGFloat] = []
    var body: some View {
        ZStack{
            HStack(spacing: 0) {
                TabBarButton(image: "house", selectedTab: $selectedTab, tabPoints: $tabPoints)
                
                TabBarButton(image: "message", selectedTab: $selectedTab, tabPoints: $tabPoints)
                
                TabBarButton(image: "cart", selectedTab: $selectedTab, tabPoints: $tabPoints)
                
                TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints)
            }
            .padding()
            .background(
                Color.verydarkblue
                    .clipShape(TabCurve(tabPoint: getCurvepoint() - 15))
            )
            .overlay(
                Circle()
                    .fill(Color.verydarkblue)
                    .frame(width: 10, height: 10)
                    .offset(x: getCurvepoint() - 20), alignment: .bottomLeading
            )
            .cornerRadius(30)
            .padding(.horizontal)
            
        }
    }
    
    func getCurvepoint() -> CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case "house":
                return tabPoints[0]
            case "message":
                return tabPoints[1]
            case "cart":
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(SessionServiceImpl())
        }
    }
}

struct TabBarButton: View {
    
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    
    var body: some View {
        GeometryReader{ reader  -> AnyView in
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                // avoid junk data
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            return AnyView(
                Button(action: {
                    //changing tab
                    //spring animation 
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                        selectedTab = image
                    }
                }, label: {
                    // filling the color if it selected
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color("whiteMain"))
                    // Lifting view
                        .offset(y: selectedTab == image ? -10 : 0)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
           )
        }
        .frame(height: 50)
    }
    
}
