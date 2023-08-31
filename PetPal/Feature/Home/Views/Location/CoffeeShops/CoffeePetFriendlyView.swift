//
//  CoffeePetFriendlyView.swift
//  PetPal
//
//  Created by Andrew on 30.05.2023.
//

import SwiftUI
import MapKit

struct Cafe: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    static func == (lhs: Cafe, rhs: Cafe) -> Bool {
        return lhs.id == rhs.id
    }
}

var cafes: [Cafe] = [
    Cafe(name: "Family Cafe", latitude: 50.445015761900066, longitude: 30.38045931145449),
    Cafe(name: "Кав'ярня Come and Stay", latitude: 50.43916398009237, longitude: 30.51763781349235),
    Cafe(name: "Альтруїст", latitude: 50.43938381206413, longitude: 30.513998328835882),
    Cafe(name: "Друзі", latitude: 50.457239462983104, longitude: 30.434094199999997),
    Cafe(name: "First Point Espresso Bar", latitude: 50.46776550826832, longitude: 30.511674599999992),
]

struct CafeMapView: View {
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var selectedCafe: Cafe?
    @State private var mapRegion: MKCoordinateRegion?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Coffee".localized)
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
                    MapViewForCafe(userLocation: location, cafes: cafes, selectedCafe: $selectedCafe, region: $mapRegion)
                } else {
                    MapViewForCafe(userLocation: CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234), cafes: cafes, selectedCafe: $selectedCafe, region: $mapRegion)
                }
                
                if let selectedCafe = selectedCafe {
                    Text(selectedCafe.name)
                        .font(.headline)
                        .padding()
                }
                
                List(cafes) { cafe in
                    Button(action: {
                        selectedCafe = cafe
                        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cafe.latitude, longitude: cafe.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    }) {
                        Text(cafe.name)
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

struct MapViewForCafe: View {
    var userLocation: CLLocationCoordinate2D
    var cafes: [Cafe]
    @Binding var selectedCafe: Cafe?
    @Binding var region: MKCoordinateRegion?
    
    var body: some View {
        Map(coordinateRegion: regionBinding, annotationItems: visibleCafes) { cafe in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: cafe.latitude, longitude: cafe.longitude)) {
                Image(systemName: "mappin")
                    .font(.title)
                    .foregroundColor(cafe == selectedCafe ? .red : .gray)
                    .onTapGesture {
                        selectedCafe = cafe
                    }
            }
        }
    }
    
    private var visibleCafes: [Cafe] {
        if let selectedCafe = selectedCafe {
            return [selectedCafe]
        } else {
            return cafes
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




struct CafeMapView_Previews: PreviewProvider {
    static var previews: some View {
        CafeMapView()
    }
}


