//
//  ProfileView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AuntentificacionViewModel.self) private var viewModel
    var body: some View {
        VStack {
            Button("lodout") {
                viewModel.logout()
            }
            .buttonStyle(DigidexPrimaryButtonStyle())
        }
    }
}

#Preview {
    ProfileView()
}

