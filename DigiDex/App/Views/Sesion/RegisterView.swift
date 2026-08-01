//
//  RegisterView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct RegisterView: View {
    @Environment(AuthViewModel.self) private var viewModel
    @Binding var showingRegister: Bool
    
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Text("Registrarse")
                .font(.title)
                .fontWeight(.bold)
            VStack(spacing: 15) {
                TextField("Correo", text: $email)
                    .textFieldStyle(DigidexTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                TextField("Usuario", text: $username)
                    .textFieldStyle(DigidexTextFieldStyle())
                    .autocorrectionDisabled()
                
                SecureField("Contraseña", text: $password)
                    .textFieldStyle(DigidexTextFieldStyle())
                
                SecureField("Confirmar contraseña", text: $confirmPassword)
                    .textFieldStyle(DigidexTextFieldStyle())
            }
            .padding(.bottom, 10)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(.digidexRed)
            }
            Button("Registrarse") {
                viewModel.registrer(email: email, username: username, pass: password, repeatPass: confirmPassword)
            }
            .buttonStyle(DigidexPrimaryButtonStyle())
            
            Button {
                viewModel.errorMessage = nil
                showingRegister = false
                
            } label: {
                (Text("¿Ya tienes cuenta?").foregroundStyle(Color.digidexTextSecondary)
                 + Text("Inicia sesión").foregroundStyle(Color.digidexAmber).bold())
                .font(.footnote)
            }
               
        }
        .padding(20)
       
    }
}

#Preview {
    RegisterView(showingRegister: .constant(false))
        .environment(AuthViewModel())
}
