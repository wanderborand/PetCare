//
//  CleaningView.swift
//  PetPal
//
//  Created by Andrew on 31.05.2023.
//

import SwiftUI

struct CleaningView: View {
    @Environment(\.self) var env
    @State private var isShowingForm1 = false
    @State private var isShowingForm2 = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    env.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .contentShape(Rectangle())
                        .foregroundColor(.whiteMain)
                })
                .padding()
                Spacer()
            }

            Text("Cleaning".localized)
                .font(.title)
                .foregroundColor(.whiteMain)
                .fontWeight(.heavy)

            Image("Cliening")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding()
                .frame(maxWidth: .infinity)

            Spacer()

            VStack {

                VStack {
                    Text("CleaningSubTitle".localized)
                        .font(.title3)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                .padding()
                
                HStack {
                    Button(action: {
                        isShowingForm1 = true
                    }, label: {
                        Image(systemName: "square.and.pencil")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                    })

                    Button(action: {
                        isShowingForm2 = true
                    }, label: {
                        Image(systemName: "bell.and.waveform")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                    })
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                Color.whiteMain
                    .clipShape(CustomShape(cornes: [.topLeft, .topRight], radius: 35))
                    .ignoresSafeArea(.all, edges: .bottom)
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("pink").ignoresSafeArea())
        .sheet(isPresented: $isShowingForm1, content: {
            NotesFirst()
        })
        .sheet(isPresented: $isShowingForm2, content: {
            ReminderListView()
        })
    }
}

struct CleaningView_Previews: PreviewProvider {
    static var previews: some View {
        CleaningView()
    }
}

