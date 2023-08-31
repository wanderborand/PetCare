//
//  ProfileView.swift
//  PetPal
//
//  Created by Andrew on 24.05.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var service: SessionServiceImpl
    @State private var darkTheme = false
    
    var body: some View {
        
        Form {
            
            HStack {
                Text("Profile".localized)
                    .font(.largeTitle)
                Spacer(minLength: 80)
                Image("welcomePage_1")
                    .resizable()
                    .clipped()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2.0))
            }
            
            Section(header: Text("YourInformation".localized)) {
                HStack {
                    Text("Firstname".localized)
                    Spacer(minLength: 100)
                    Text("\(service.userDetails?.firstName ?? "N/A")")
                }
                
                HStack {
                    Text("Lastname".localized)
                    Spacer(minLength: 100)
                    Text("\(service.userDetails?.lastName ?? "N/A")")
                }
            }
            
            Section(header: Text("PetInformation".localized)) {
                HStack {
                    Text("Petname".localized)
                    Spacer(minLength: 100)
                    Text("\(service.userDetails?.occupation ?? "N/A")")
                }
                
                HStack {
                    Text("Addanotherpet".localized)
                    Spacer(minLength: 100)
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .contentShape(Rectangle())
                        .foregroundColor(.blueMain)
                }
            }
            
            Section(header: Text("System".localized)) {
                Toggle(isOn: $darkTheme) {
                    Text("Theme".localized)
                }
                
                Button {
                    service.logout()
                } label: {
                    Label("Logout".localized, systemImage: "nosign")
                        .foregroundColor(.orangeMain)
                }
            }
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(SessionServiceImpl())
        }
    }
}
