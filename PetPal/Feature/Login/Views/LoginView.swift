//
//  LoginView.swift
//  PetPal
//
//  Created by Andrew on 20.05.2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    @StateObject private var viewModel = LoginViewModelImpl(
        service: LoginServiceImpl()
    )
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            HStack{
                Text("Login".localized)
                    .font(.largeTitle)
                    .foregroundColor(.verydarkblue)
                    .fontWeight(.bold)
                
                Image(systemName: "pawprint.fill")
                    .font(.title)
                    .foregroundColor(.blueMain)
                
            }
            .padding(.bottom, 60)
            
            VStack(spacing: 16) {
                
                InputTextFieldView(text: $viewModel.credentials.email,
                                   placeholder: "Email".localized,
                                   keyboardType: .emailAddress,
                                   systemImage: "envelope")
                
                InputPasswordView(password: $viewModel.credentials.password,
                                  placeholder: "Password".localized,
                                  systemImage: "lock")
            }
            
            HStack {
                Spacer()
                Button(action: {
                    showForgotPassword.toggle()
                }, label: {
                    Text("Reset".localized)
                })
                .font(.system(size: 16, weight: .bold))
                .sheet(isPresented: $showForgotPassword) {
                        ForgotPasswordView()
                }
            }
            .padding(.bottom, 26)
            
            VStack(spacing: 16) {
                
                ButtonView(title: "Login".localized) {
                    viewModel.login()
                }
                
                ButtonView(title: "Register".localized,
                           background: .clear,
                           foreground: .blueMain,
                           border: .blueMain) {
                    showRegistration.toggle()
                }
                .sheet(isPresented: $showRegistration) {
                        RegisterView()
                }
            }
        }
        .padding(.horizontal, 15)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}


struct ButtonView: View {
    
    typealias ActionHandler = () -> Void
    
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    
    private let cornerRadius: CGFloat = 10
    
    internal init(title: String,
                  background: Color = .blueMain,
                  foreground: Color = .whiteMain,
                  border: Color = .clear,
                  handler: @escaping ButtonView.ActionHandler) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.handler = handler
    }
    
    var body: some View {
        
        Button(action: {
            handler()
        }, label: {
            Text(title)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 50)
        })
        .background(background)
        .foregroundColor(foreground)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(border, lineWidth: 2)
        )
    }
}

struct InputTextFieldView: View {
    
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let systemImage: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        
        VStack {
            
            TextField(placeholder, text: $text)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       minHeight: 44,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.leading, systemImage == nil ? textFieldLeading / 2 : textFieldLeading)
                .keyboardType(keyboardType)
                .background(
                    
                    ZStack(alignment: .leading) {
                        
                        if let systemImage = systemImage {
                            
                            Image(systemName: systemImage)
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.leading, 5)
                                .foregroundColor(Color.gray.opacity(0.5))
                        }
                        
                        RoundedRectangle(cornerRadius: 10,
                                         style: .continuous)
                            .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                    }
                )
        }
    }
}

struct InputPasswordView: View {
    
    @Binding var password: String
    let placeholder: String
    let systemImage: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        
        VStack {
            
            SecureField(placeholder, text: $password)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       minHeight: 44,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.leading, systemImage == nil ? textFieldLeading / 2 : textFieldLeading)
                .background(
                    
                    ZStack(alignment: .leading) {
                        
                        if let systemImage = systemImage {
                            
                            Image(systemName: systemImage)
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.leading, 5)
                                .foregroundColor(Color.gray.opacity(0.5))
                        }
                        
                        RoundedRectangle(cornerRadius: 10,
                                         style: .continuous)
                            .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                    }
                )
        }
    }
}
