    //
    //  Root.swift
    //  DigiDex
    //
    //  Created by Osasu sanchez on 21/07/2026.
    //

import SwiftUI

struct Root: View {
    @Environment(AuntentificacionViewModel.self) private var auntVM
    @State private var isShowingSplash = true
    
    var body: some View {
        Group {
            if isShowingSplash {
                SplashView(isShowing: $isShowingSplash)
            }  else if auntVM.isAuthenticated {
                mainTabView()
               
            }else {
                AuthContenVeiw()
            }
        }
    }
}
    
