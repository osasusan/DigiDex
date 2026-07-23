//
//  ContentView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 09/06/2026.
//

import SwiftUI

struct AuthContenVeiw: View {
    @State private var isSignUp: Bool = false
    var body: some View {
        ZStack{
            Color.digidexBackground.ignoresSafeArea()
            
            Group {
                if isSignUp {
                    RegisterView(showingRegister: $isSignUp)
                }else{
                    LoginView(showLogin: $isSignUp)
                
                }
            }
            .padding()
        }
    }
}

#Preview {
    AuthContenVeiw()
        .environment(AuntentificacionViewModel())
}
