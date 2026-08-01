//
//  LoginView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct LoginView: View {
    @Environment(AuthViewModel.self) private var viewModel
    @Binding var showLogin: Bool
    
    @State private var username: String = ""
    @State private var pass: String = ""
    
    var body: some View {
        
        VStack{
        VStack(spacing: 10) {
            TextField("Usuario", text: $username)
                .textFieldStyle(DigidexTextFieldStyle())
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            SecureField("Contraseña", text: $pass)
                .textFieldStyle(DigidexTextFieldStyle())
              
        }
        .padding(15)
            if let error = viewModel.errorMessage {
              Text(error)
                    .font(.footnote)
                    .foregroundStyle(Color.digidexRed)
            }
            Button("Inicar sesion") {
                viewModel.login(userName: username, pass: pass)
            }
            .buttonStyle(DigidexPrimaryButtonStyle())
            .padding(.horizontal,20)
            
            Button {
                viewModel.errorMessage = nil
                showLogin.toggle()
            } label: {
                (Text("No tienes una cuenta?")
                    .foregroundStyle(Color.digidexTextSecondary)
                 + Text(" Regístrate")
                 
                    .foregroundStyle(Color.digidexAmber)
                    .bold())
                 .font(.footnote)
            }
        }
       
    }
}

struct DigidexPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(Color.digidexBackground)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.digidexAmber.opacity(configuration.isPressed ? 0.8 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct DigidexTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Color.digidexSurface)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.digidexBorder, lineWidth: 0.5)
            )
    }
}

#Preview {
    ZStack {
        Color.digidexBackground.ignoresSafeArea()
        LoginView(showLogin: .constant(false))
            .environment(AuthViewModel())
            
    }
}
