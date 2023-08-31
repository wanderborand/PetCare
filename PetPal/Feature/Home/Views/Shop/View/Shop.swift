//
//  Shop.swift
//  PetPal
//
//  Created by Andrew on 01.06.2023.
//

import SwiftUI

struct Shop: View {
    @State var currentIndex: Int = 0
    @State var currentTab: Tab = tabs[0]
    @Namespace var animation
    
    @State var selectedClothes: Clothes?
    @State var showDetails: Bool = false
    
    
    var body: some View {
        VStack {
            HeaderView()
            
//            VStack(alignment: .leading, spacing: 8) {
//                Text(attributedtitle)
//                    .font(.largeTitle.bold())
//                Text(attributedSubTitle)
//                    .font(.largeTitle.bold())
//            }
//            .padding(.horizontal, 15)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .opacity(showDetails ? 0 : 1)
            
            GeometryReader{ proxy in
                let size = proxy.size
                CarouselView(size: size)
            }
            .zIndex(-10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(content: {
            if let selectedClothes = selectedClothes, showDetails {
                DetailView(animation: animation, clothes: selectedClothes, show: $showDetails)
            }
        })
        .background{
            Color("blueLight")
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func CarouselView(size: CGSize)-> some View {
        VStack(spacing: -40){
            CustomCarousel(index: $currentIndex, items: clothes, spacing: 0, cardPadding: size.width / 3, id: \.id) {
                clothes, _ in
                
                VStack(spacing: 10) {
                    ZStack{
                        if showDetails && selectedClothes?.id == clothes.id {
                            Image(clothes.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                                .opacity(0)
                        } else {
                            Image(clothes.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                                .matchedGeometryEffect(id: clothes.id, in: animation)
                        }
                    }
//                    .background{
//                        RoundedRectangle(cornerRadius: size.height / 10, style: .continuous)
//                            .fill(Color("pink"))
//                            .padding(.horizontal, -40)
//                            .offset(y: -10)
//                    }
                            
                    Text(clothes.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                    
                    Text(clothes.price)
                        .font(.callout)
                        .fontWeight(.black)
                        .foregroundColor(Color("pink"))
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                        selectedClothes = clothes
                        showDetails = true
                    }
                }
            }
            .frame(height: size.height * 0.8)
            
            //Indicators()
                
        }
        //!!!
        .padding(.top, 50)
        .frame(width: size.width, height: size.height)
        .opacity(showDetails ? 0 : 1)
        .background{
            CustomArcShape()
                .fill(.white)
                .scaleEffect(showDetails ? 1.8 : 1, anchor: .bottomLeading)
                .overlay(alignment: .topLeading, content: {
                    TabMenu()
                        .opacity(showDetails ? 0 : 1)
                })
                .padding(.top, 40)
                .ignoresSafeArea()
                
        }
    }
    
    @ViewBuilder
    func TabMenu()-> some View {
        HStack(spacing: 30) {
            ForEach(tabs){ tab in
                Image(tab.tabImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 50)
                    .padding(10)
                    .background{
                        Circle()
                            .fill(Color("whiteMain"))
                    }
                    .background(content: {
                        Circle()
                            .fill(.white)
                            .padding(-2)
                    })
                    .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
                    .offset(tab.tabOffset)
                    .scaleEffect(currentTab.id == tab.id ? 1.15 : 0.94, anchor: .bottom)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            currentTab = tab
                        }
                    }
            }
        }
        .padding(.leading, 15)
    }
    
//    @ViewBuilder
//    func Indicators() -> some View {
//        HStack(spacing: 2) {
//            ForEach(clothes.indices, id: \.self) {index in
//                Circle()
//                    .fill(Color("pink"))
//                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
//                    .padding(4)
//                    .background{
//                        if currentIndex == index {
//                            Circle()
//                                .stroke(Color("pink"), lineWidth: 1)
//                                .matchedGeometryEffect(id: "INDICATOR", in: animation)
//                        }
//                    }
//            }
//        }
//        .animation(.easeInOut, value: currentIndex)
//    }
    
    @ViewBuilder
    func HeaderView()->some View{
        HStack {
            Button{
                
            } label: {
                HStack(spacing: 10){
//                    Image("remind3")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 35, height: 35)
//                        .clipShape(Circle())
                    
                    Text("NameShop".localized)
                        .font(.largeTitle.bold())
                        //.font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                }
//                .padding(.leading, 8)
//                .padding(.trailing, 12)
//                .padding(.vertical, 6)
                .padding(.bottom, 20)
//                .background{
//                    Capsule()
//                        .fill(Color("whiteMain"))
//                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(showDetails ? 0 : 1)
            
            
            Button {
                
            } label: {
                Image(systemName: "cart")
                    .font(.title2)
                    .foregroundColor(.black)
                    .overlay(alignment: .topTrailing) {
                        Circle()
                            .fill()
                            .frame(width: 10, height: 10)
                            .offset(x: 2, y: -5)
                    }
            }
        }
        .padding(15)
    }
    
//    var attributedtitle: AttributedString {
//        var attString = AttributedString(stringLiteral: "Good Shop,")
//        if let range = attString.range(of: "Shop.") {
//            attString[range].foregroundColor = .white
//        }
//        return attString
//    }
    
//    var attributedSubTitle: AttributedString {
//        var attString = AttributedString(stringLiteral: "Good Mood,")
//        if let range = attString.range(of: "Good.") {
//            attString[range].foregroundColor = .white
//        }
//        return attString
//    }
}

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Shop()
    }
}


struct DetailView: View {
    var animation: Namespace.ID
    var clothes: Clothes
    @Binding var show: Bool
    
    @State var orderType: String = "ActiveOrder".localized
    @State var showContent: Bool = false
    var body: some View{
        
        VStack{
            HStack {
                Button{
                    withAnimation(.easeInOut(duration: 0.35)){
                        showContent = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 0.35)){
                            show = false
                        }
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .overlay{
                Text("Details".localized)
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            .padding(.top, 7)
            .opacity(showContent ? 1 : 0)
            
            HStack(spacing: 0) {
                ForEach(["ActiveOrder".localized, "PastOrder".localized], id: \.self){order in
                    Text(order)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(orderType == order ? .black : .gray)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background{
                            if orderType == order {
                                Capsule()
                                    .fill(Color("pink"))
                                    .matchedGeometryEffect(id: "ORDERTAB", in: animation)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut){ orderType = order
                                
                            }
                        }
                }
            }
            .padding(.leading, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            .opacity(showContent ? 1 : 0)
            
//            Image(clothes.image)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .rotationEffect(.init(degrees: -2))
//                .matchedGeometryEffect(id: clothes.id, in: animation)
            
            GeometryReader{ proxy in
                let size  = proxy.size
                ClothesDetails()
                    .offset(y: showContent ? 0 : size.height + 50)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .transition(.asymmetric(insertion: .identity, removal: .offset(y: 0.5)))
        .onAppear{
            withAnimation(.easeInOut.delay(0.1)){
                showContent = true
            }
        }
    }
    
    @ViewBuilder
    func ClothesDetails()->some View{
        VStack {
            VStack(spacing: 12) {
                Text("#512D")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Text(clothes.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text(clothes.price)
                    .font(.callout)
                    .fontWeight(.black)
                    .foregroundColor(Color("red"))
//
//                Text("20min delivery")
//                    .font(.caption)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.gray)
                
                HStack(spacing: 12){
                    Text("Quantity".localized)
                        .font(.callout.bold())
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "minus")
                            .font(.title3)
                    }
                    
                    Text("\(2)")
                        .font(.title3)
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
                .foregroundColor(.gray)
                
                Button {
                    
                } label: {
                    Text("Order".localized)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .background{
                            Capsule()
                                .fill(Color("pink"))
                        }
                }
                .padding(.top, 10)
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background{
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .fill(.gray.opacity(0.08))
            }
            .padding(.horizontal, 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
