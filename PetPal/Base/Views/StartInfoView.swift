//
//  StartInfoView.swift
//  PetPal
//
//  Created by Andrew on 20.05.2023.
// StartInfoView

import SwiftUI
import Firebase

struct StartInfoView: View {
    
    @State private var activeIntro: PageIntro = pageIntros[0]
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var showNewForm: Bool = false

    var body: some View {
        GeometryReader {
            let size = $0.size
            
            IntroView(intro: $activeIntro, size: size) {
                
                Spacer()
                
                Button {
                    showNewForm = true
                } label: {
                    Text("Continue".localized)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(Color("blueMain"))
                        }
                }
                .sheet(isPresented: $showNewForm, content:{LoginView()})
            }
        }
        .padding(15)
        
    }
}

struct StartInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Intro View
struct IntroView<ActionView: View>: View {
    @Binding var intro: PageIntro
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<PageIntro>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
    }
    
    // Animation Properties
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    
    var body: some View {
        VStack {
            // Image View
            GeometryReader {
                let size = $0.size
                
                Image(intro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
            }
            // Moving Up
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            
            // Title & Action`s
            VStack(alignment: .leading, spacing: 10) {
                Spacer(minLength: 0)
                
                Text(intro.title)
                    .font(.system(size: 28))
                    .foregroundColor(.verydarkblue)
                    .fontWeight(.bold)
                Text(intro.subTitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 15)
                
                if !intro.displaysAction {
                    Group {
                        Spacer(minLength: 25)
                        
                        // Custom Indicator View
                        CustomindicatorView(totalPages: filteredPages.count, currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        
                        Button {
                            changeIntro()
                        } label: {
                            Text("Next".localized)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: size.width * 0.4)
                                .padding(.vertical, 15)
                                .background {
                                    Capsule()
                                        .fill(Color("blueMain"))
                                }
                        }
                        .frame(maxWidth: .infinity)
                    }
                } else {
                    // Action View
                    actionView
                        .offset(y: showView ? 0 : size.height / 2)
                        .opacity(showView ? 1 : 0)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            // Moving Down
            .offset(y: showView ? 0 : size.height / 2)
            .opacity(showView ? 1 : 0)
        }
        .offset(y: hideWholeView ? size.height / 2 : 0)
        .opacity(hideWholeView ? 0 : 1)
        
        // Back Button
        .overlay(alignment: .topLeading) {
            if intro != pageIntros.first {
                Button {
                    changeIntro(true)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .contentShape(Rectangle())
                        .foregroundColor(.blueMain)
                        
                }
                .padding(10)
                //Animatting Back Button
                .offset(y: showView ? 0 : -200)
                .offset(y: hideWholeView ? -200 : 0)
            }

        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                showView = true
            }
        }
    }
    
    // Updating Page Intro`s
    func changeIntro(_ isPrevios: Bool = false) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
            hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // Updating Page
            if let index = pageIntros.firstIndex(of: intro), (isPrevios ? index != 0 : index != pageIntros.count - 1) {
                intro = isPrevios ? pageIntros[index - 1] : pageIntros[index + 1]
            } else {
                intro = isPrevios ? pageIntros[0] : pageIntros[pageIntros.count - 1]
            }
            //Re-Animating as Split Page
            hideWholeView = false
            showView =  false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                showView = true
            }
        }
        
    }
    
    var filteredPages: [PageIntro] {
        return pageIntros.filter {
            !$0.displaysAction
        }
    }
}
