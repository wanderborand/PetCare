//
//  RegisterView.swift
//  PetPal
//
//  Created by Andrew on 20.05.2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegistrationViewModelImpl(
        service: RegistrationServiceImpl()
    )
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 32) {
                
                HStack{
                    Text("Signup".localized)
                        .font(.largeTitle)
                        .foregroundColor(.verydarkblue)
                        .fontWeight(.bold)
                    
                    Image(systemName: "pawprint.fill")
                        .font(.title)
                        .foregroundColor(.blueMain)
                    
                }
                .padding(.bottom, 60)
                
                VStack(spacing: 16) {
                    
                    InputTextFieldView(text: $viewModel.newUser.email,
                                       placeholder: "Email".localized,
                                       keyboardType: .emailAddress,
                                       systemImage: "envelope")
                    
                    InputPasswordView(password: $viewModel.newUser.password,
                                      placeholder: "Password".localized,
                                      systemImage: "lock")
                    
                    Divider()
                    
                    InputTextFieldView(text: $viewModel.newUser.firstName,
                                       placeholder: "Firstname".localized,
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    
                    InputTextFieldView(text: $viewModel.newUser.lastName,
                                       placeholder: "Lastname".localized,
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    
                    InputTextFieldView(text: $viewModel.newUser.occupation,
                                       placeholder: "Petname".localized,
                                       keyboardType: .namePhonePad,
                                       systemImage: nil)
                    
                    Text("Addpetlater".localized)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                ButtonView(title: "Signup".localized) {
                    viewModel.create()
                }
            }
            .padding(.horizontal, 15)
            .applyClose()
            .alert(isPresented: $viewModel.hasError,
                   content: {
                    
                    if case .failed(let error) = viewModel.state {
                        return Alert(
                            title: Text("Error".localized),
                            message: Text(error.localizedDescription))
                    } else {
                        return Alert(
                            title: Text("Error".localized),
                            message: Text("Wrong".localized))
                    }
            })
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
            RegisterView()
    }
}
