import SwiftUI

struct PetCareView: View {
    let animalTypes = ["Dog".localized, "Cat".localized, "Parrot".localized, "Rodents".localized]
    let dogBreeds = ["Bulldog".localized, "Labrador".localized, "Husky".localized, "Spitz".localized, "Poodle".localized, "Beagle".localized, "Rottweiler".localized]
    let catBreeds = ["Persian".localized, "Siamese".localized, "MaineCoon".localized, "Sphinx".localized, "Bengal".localized]
    let parrotBreeds = ["Macaw".localized, "Lovebird".localized, "Cockatoo".localized]
    let rodentsBreeds = ["Hamster".localized, "Mice".localized, "Rabbit".localized, "Rat".localized, "Mole".localized]
    
    @State private var selectedAnimalType = 0
    @State private var selectedBreed = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("ChooseAnimal")) {
                    Picker(selection: $selectedAnimalType, label: Text("")) {
                        ForEach(0..<animalTypes.count) { index in
                            Text(self.animalTypes[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("ChooseBreed")) {
                    breedOptions()
                }
                
                Section {
                    NavigationLink(destination: getCareView()) {
                        Text("GoTips")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .disabled(selectedBreed == 0)
                }
            }
            .navigationTitle("Details")
        }
    }
    
    func breedOptions() -> some View {
        switch selectedAnimalType {
        case 0:
            return AnyView(Picker(selection: $selectedBreed, label: Text("")) {
                ForEach(0..<dogBreeds.count) { index in
                    if index < dogBreeds.count {
                        Text(self.dogBreeds[index])
                    }
                }
            }
            .pickerStyle(DefaultPickerStyle()))
        case 1:
            return AnyView(Picker(selection: $selectedBreed, label: Text("")) {
                ForEach(0..<catBreeds.count) { index in
                    if index < catBreeds.count {
                        Text(self.catBreeds[index])
                    }
                }
            }
            .pickerStyle(DefaultPickerStyle()))
        case 2:
            return AnyView(Picker(selection: $selectedBreed, label: Text("")) {
                ForEach(0..<parrotBreeds.count) { index in
                    if index < parrotBreeds.count {
                        Text(self.parrotBreeds[index])
                    }
                }
            }
            .pickerStyle(DefaultPickerStyle()))
        case 3:
            return AnyView(Picker(selection: $selectedBreed, label: Text("")) {
                ForEach(0..<rodentsBreeds.count) { index in
                    if index < rodentsBreeds.count {
                        Text(self.rodentsBreeds[index])
                    }
                }
            }
            .pickerStyle(DefaultPickerStyle()))
        default:
            return AnyView(EmptyView())
        }
    }
    
    func getCareView() -> AnyView {
        switch selectedAnimalType {
        case 0:
            if selectedBreed < dogBreeds.count && selectedBreed >= 0 {
                let dogBreed = dogBreeds[selectedBreed]
                return AnyView(CareView(breed: dogBreed))
            } else {
                return AnyView(EmptyView())
            }
        case 1:
            if selectedBreed < catBreeds.count && selectedBreed >= 0 {
                let catBreed = catBreeds[selectedBreed]
                return AnyView(CareView(breed: catBreed))
            } else {
                return AnyView(EmptyView())
            }
        case 2:
            if selectedBreed < parrotBreeds.count && selectedBreed >= 0 {
                let parrotBreed = parrotBreeds[selectedBreed]
                return AnyView(CareView(breed: parrotBreed))
            } else {
                return AnyView(EmptyView())
            }
        case 3:
            if selectedBreed < parrotBreeds.count && selectedBreed >= 0 {
                let parrotBreed = parrotBreeds[selectedBreed]
                return AnyView(CareView(breed: parrotBreed))
            } else {
                return AnyView(EmptyView())
            }
        default:
            return AnyView(EmptyView())
        }
    }

}


struct CatCareView: View {
    let breed: String
    
    var body: some View {
        VStack {
            Text("Догляд за котом породи \(breed)")
                .font(.title)
                .padding()
        }
        .navigationTitle("Догляд за котом")
    }
    
    
    
}

struct ParrotCareView: View {
    let breed: String
    
    var body: some View {
        VStack {
            Text("Догляд за папугою породи \(breed)")
                .font(.title)
                .padding()
        }
        .navigationTitle("Догляд за папугою")
    }
}

struct RodentsCareView: View {
    let breed: String
    
    var body: some View {
        VStack {
            Text("Догляд за гризуном породи \(breed)")
                .font(.title)
                .padding()
        }
        .navigationTitle("Догляд за папугою")
    }
}

struct PetCareView_Previews: PreviewProvider {
    static var previews: some View {
        PetCareView()
    }
}

