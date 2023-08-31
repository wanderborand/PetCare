//
//  SheltersView.swift
//  PetPal
//
//  Created by Andrew on 30.05.2023.
//

import SwiftUI
import MapKit

struct Shelter: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    static func == (lhs: Shelter, rhs: Shelter) -> Bool {
        return lhs.id == rhs.id
    }
}

var shelters: [Shelter] = [
    Shelter(name: "Happy Paw", latitude: 50.43947726211942, longitude: 30.518342497109078),
    
    Shelter(name: "Притулок мейн-кунів Яросвіт", latitude: 48.339423013105616, longitude: 31.17881959759157),
    
     
    Shelter(name: "Притулок для тварин", latitude: 50.585048055023265, longitude: 30.26335902033974),
     
    Shelter(name: "Cats for Adoption Kyiv", latitude: 50.455155146381664, longitude: 30.52331414308791),
     
    Shelter(name: "У добрі руки", latitude: 50.43764544383614, longitude: 30.23248171863725),
]

struct SheltersMapView: View {
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var selectedShelter: Shelter?
    @State private var mapRegion: MKCoordinateRegion?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Shelters".localized)
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                    }
            }
            .padding()
            
            VStack {
                if let location = userLocation {
                    MapViewForShelters(userLocation: location, shelters: shelters, selectedShelter: $selectedShelter, region: $mapRegion)
                } else {
                    MapViewForShelters(userLocation: CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234), shelters: shelters, selectedShelter: $selectedShelter, region: $mapRegion)
                }
                
                if let selectedShelter = selectedShelter {
                    Text(selectedShelter.name)
                        .font(.headline)
                        .padding()
                }
                
                List(shelters) { shelter in
                    Button(action: {
                        selectedShelter = shelter
                        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: shelter.latitude, longitude: shelter.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    }) {
                        Text(shelter.name)
                    }
                }
                .frame(height: 200)
            }
            .onAppear {
                getLocation()
            }
        }
    }
    
    private func getLocation() {
        // Отримання місцезнаходження користувача
        // Встановіть значення userLocation, якщо геолокація доступна
        // Якщо геолокація не доступна, встановіть userLocation як nil
        
        // В цьому прикладі встановлюємо фіксовані координати Києва
        userLocation = CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234)
    }
}

struct MapViewForShelters: View {
    var userLocation: CLLocationCoordinate2D
    var shelters: [Shelter]
    @Binding var selectedShelter: Shelter?
    @Binding var region: MKCoordinateRegion?
    
    var body: some View {
        Map(coordinateRegion: regionBinding, annotationItems: visibleShelters) { shelter in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: shelter.latitude, longitude: shelter.longitude)) {
                Image(systemName: "mappin")
                    .font(.title)
                    .foregroundColor(shelter == selectedShelter ? .red : .gray)
                    .onTapGesture {
                        selectedShelter = shelter
                    }
            }
        }
    }
    
    private var visibleShelters: [Shelter] {
        if let selectedShelter = selectedShelter {
            return [selectedShelter]
        } else {
            return shelters
        }
    }
    
    private var regionBinding: Binding<MKCoordinateRegion> {
        Binding<MKCoordinateRegion>(
            get: { region ?? regionFromUserLocation },
            set: { _ in }
        )
    }
    
    private var regionFromUserLocation: MKCoordinateRegion {
        MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
}

struct SheltersMapView_Previews: PreviewProvider {
    static var previews: some View {
        SheltersMapView()
    }
}
