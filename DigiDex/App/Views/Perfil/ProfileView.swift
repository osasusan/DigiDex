    //
    //  ProfileView.swift
    //  DigiDex
    //
    //  Created by Osasu sanchez on 21/07/2026.
    //

import SwiftUI
import PhotosUI


struct ProfileView: View {
    @Environment(AuthViewModel.self) var viewModel
    
    @State private var edidtName: Bool = false
    @State private var newUsername: String = ""
    
    @State private var chagePassword: Bool = false
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorPass: String?
    
    @State private var photoSelect: PhotosPickerItem?
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing:24){
                    avatarSection
                    VStack(spacing: 10) {
                        
                        
                        ProfileOptionCard(title: "Cambiar nombre", isExpanded: $edidtName) {
                            VStack(spacing: 10) {
                                TextField("Nuevo nombre",text: $newUsername)
                                    .textFieldStyle(DigidexTextFieldStyle())
                                Button {
                                    viewModel.updateProfile(username: newUsername)
                                    newUsername = ""
                                    edidtName.toggle()
                                    
                                } label: {
                                    Text("Guardar")
                                    
                                }
                                .buttonStyle(DigidexPrimaryButtonStyle())
                                .disabled(newUsername.isEmpty)
                            }
                        }
                        ProfileOptionCard(title: "Camniar contraseña", isExpanded: $chagePassword) {
                            VStack(spacing: 10) {
                                SecureField("Nueva contraseña",text: $newPassword)
                                    .textFieldStyle(DigidexTextFieldStyle())
                                SecureField("Confirmar contraseña",text: $confirmPassword)
                                    .textFieldStyle(DigidexTextFieldStyle())
                                
                                if let errorPass {
                                    Text(errorPass)
                                        .font(.caption)
                                        .foregroundStyle(Color.digidexRed)
                                }
                                Button{
                                    guard !newPassword.isEmpty, newPassword == confirmPassword else {
                                        errorPass = "Las contraseñas no coinciden."
                                        return
                                    }
                                    viewModel.updateProfile(newPassword: newPassword)
                                    newPassword = ""
                                    confirmPassword = ""
                                    chagePassword.toggle()
                                } label: {
                                    Text("Guardar")
                                }
                                .buttonStyle(DigidexPrimaryButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal,20)
                }
                Button("Cerrar sesion") {
                    viewModel.logout()
                }
                .font(Font.body.bold())
                .foregroundStyle(.digidexRed)
            }
            .navigationTitle("Perfil")
            .background(.digidexBackground)
        }
    }
    var imageAvtar: some View {
        Group{
            if let data = viewModel.currentUser?.profileImageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Circle()
                    .fill(Color.digidexCard)
                    .overlay(
                        Text(String(viewModel.currentUser?.username.prefix(1) ?? "?").uppercased())
                            .font(.largeTitle.bold())
                            .foregroundStyle(Color.digidexAmber)
                    )
            }
        }
        .frame(width: 96, height: 96)
        .clipShape(Circle())
    }
    
    
    var  avatarSection:some View {
        VStack(spacing: 10) {
            PhotosPicker(selection: $photoSelect, matching: .images) {
                imageAvtar
            }
            .onChange(of: photoSelect) { _, newItem in
                Task { @MainActor in
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        viewModel.updateProfile(profileImageData: data)
                    }
                }
            }
            
            Text(viewModel.currentUser?.username ?? "pepito grillo")
                .font(.title3.bold())
                .foregroundStyle(.white)
            
            Text(viewModel.currentUser?.email ?? "digimon@Digidex.com")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.digidexTextSecondary)
        }
    }
}



struct ProfileOptionCard<Content: View>: View {
    let title: String
    @Binding var isExpanded: Bool
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.spring()) { isExpanded.toggle() }
            } label: {
                HStack {
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(Color.digidexTextSecondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .padding(16)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                content()
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
        }
        .digidexCardStyle()
    }
}




#Preview {
    ZStack {
        Color.digidexBackground.ignoresSafeArea()
        ProfileView()
            .environment(AuthViewModel())
    }
}
