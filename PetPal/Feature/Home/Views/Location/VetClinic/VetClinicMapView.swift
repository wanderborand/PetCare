//
//  VetClinicMapView.swift
//  PetPal
//
//  Created by Andrew on 30.05.2023.
//

import SwiftUI
import MapKit

struct VetClinic: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    static func == (lhs: VetClinic, rhs: VetClinic) -> Bool {
        return lhs.id == rhs.id
    }
}

var vetClinics: [VetClinic] = [
     
    VetClinic(name: "Альфа", latitude: 50.47933393132356, longitude: 30.447058384273653),
    
    VetClinic(name: "Білий Клик", latitude: 50.48969776585804, longitude: 30.4394573202543),
    
    VetClinic(name: "Ветеринарна клініка «Лікар Бо»", latitude: 50.475187761092606, longitude: 30.371047744080123),
    
    VetClinic(name: "ВетМакс", latitude: 50.49591497562888, longitude: 30.403623732734495),
    
    VetClinic(name: "Фенікс", latitude: 50.472423445560246, longitude: 30.352588017175982),
]

struct VetClinicMapView: View {
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var selectedVetClinic: VetClinic?
    @State private var region: MKCoordinateRegion?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("VetClinic".localized)
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
                    MapViewForVetClinic(userLocation: location, vetClinics: vetClinics, selectedVetClinic: $selectedVetClinic, region: $region)
                } else {
                    MapViewForVetClinic(userLocation: CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234), vetClinics: vetClinics, selectedVetClinic: $selectedVetClinic, region: $region)
                }
                
                if let selectedVetClinic = selectedVetClinic {
                    Text(selectedVetClinic.name)
                        .font(.headline)
                        .padding()
                }
                
                List(vetClinics) { vetClinic in
                    Button(action: {
                        selectedVetClinic = vetClinic
                        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: vetClinic.latitude, longitude: vetClinic.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    }) {
                        Text(vetClinic.name)
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
        userLocation = CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234)
    }
}

struct MapViewForVetClinic: View {
    var userLocation: CLLocationCoordinate2D
    var vetClinics: [VetClinic]
    @Binding var selectedVetClinic: VetClinic?
    @Binding var region: MKCoordinateRegion?
    
    var body: some View {
        Map(coordinateRegion: regionBinding, annotationItems: visibleVetClinics) { vetClinic in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: vetClinic.latitude, longitude: vetClinic.longitude)) {
                Image(systemName: "mappin")
                    .font(.title)
                    .foregroundColor(vetClinic == selectedVetClinic ? .red : .gray)
                    .onTapGesture {
                        selectedVetClinic = vetClinic
                        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: vetClinic.latitude, longitude: vetClinic.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    }
            }
        }
    }
    
    private var regionBinding: Binding<MKCoordinateRegion> {
        Binding<MKCoordinateRegion>(
            get: { region ?? regionFromUserLocation },
            set: { _ in }
        )
    }
    
    private var visibleVetClinics: [VetClinic] {
        if let selectedVetClinic = selectedVetClinic {
            return [selectedVetClinic]
        } else {
            return vetClinics
        }
    }
    
    private var regionFromUserLocation: MKCoordinateRegion {
        MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
}

struct VetClinicMapView_Previews: PreviewProvider {
    static var previews: some View {
        VetClinicMapView()
    }
}
