//
//  ParsView.swift
//  PetPal
//
//  Created by Andrew on 30.05.2023.
//

import SwiftUI
import MapKit

struct Park: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    static func == (lhs: Park, rhs: Park) -> Bool {
        return lhs.id == rhs.id
    }
}
var parks: [Park] = [
    Park(name: "Острівець вільних та вихованих", latitude: 50.471145128291425, longitude: 30.42413352883588),
    
    Park(name: "Майданчик для вигулу собак", latitude: 50.455204309146566, longitude: 30.48274594232824),
    
    Park(name: "Собачий парк", latitude: 50.42726443405126, longitude: 30.605345668710854),
    
    Park(name: "Сирецький парк", latitude: 50.46858452305152, longitude: 30.43903892214606),
]

struct ParkMapView: View {
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var selectedPark: Park?
    @State private var mapRegion: MKCoordinateRegion?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Park".localized)
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
                    MapViewForParks(userLocation: location, parks: parks, selectedPark: $selectedPark, region: $mapRegion)
                } else {
                    MapViewForParks(userLocation: CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234), parks: parks, selectedPark: $selectedPark, region: $mapRegion)
                }
                
                if let selectedPark = selectedPark {
                    Text(selectedPark.name)
                        .font(.headline)
                        .padding()
                }
                
                List(parks) { park in
                    Button(action: {
                        selectedPark = park
                        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: park.latitude, longitude: park.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    }) {
                        Text(park.name)
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
        userLocation = CLLocationCoordinate2D(latitude: 50.471145128291425, longitude: 30.42413352883588)
    }
}

struct MapViewForParks: View {
    var userLocation: CLLocationCoordinate2D
    var parks: [Park]
    @Binding var selectedPark: Park?
    @Binding var region: MKCoordinateRegion?
    
    var body: some View {
        Map(coordinateRegion: regionBinding, annotationItems: visibleParks) { park in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: park.latitude, longitude: park.longitude)) {
                Image(systemName: "mappin")
                    .font(.title)
                    .foregroundColor(park == selectedPark ? .red : .gray)
                    .onTapGesture {
                        selectedPark = park
                    }
            }
        }
    }
    
    private var visibleParks: [Park] {
        if let selectedPark = selectedPark {
            return [selectedPark]
        } else {
            return parks
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


struct ParkMapView_Previews: PreviewProvider {
    static var previews: some View {
        ParkMapView()
    }
}

