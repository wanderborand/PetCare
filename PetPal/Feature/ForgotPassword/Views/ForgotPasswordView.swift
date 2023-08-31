//
//  ForgotPasswordView.swift
//  PetPal
//
//  Created by Andrew on 20.05.2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var viewModel = ForgotPasswordViewModelImpl(
        service: ForgotPasswordServiceImpl()
    )
    
    var body: some View {
            VStack(spacing: 16) {
            
                InputTextFieldView(text: $viewModel.email,
                                   placeholder: "Email".localized,
                                   keyboardType: .emailAddress,
                                   systemImage: "envelope")
                
                ButtonView(title: "SendPasswordReset".localized) {
                    viewModel.sendPasswordResetRequest()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("ResetPassword".localized)
            .applyClose()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
