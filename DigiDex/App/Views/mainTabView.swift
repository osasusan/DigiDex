//
//  mainTabView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct mainTabView: View {
    @Environment(DigimonStore.self) private var sotre
    @State private var tabSelection:AppTab = .home
    
    var body: some View {
        VStack(spacing:12){
            Group{
                switch tabSelection {
                    case .home:
                        HomeView()
                    case .digidex:
                        DigiDexView()
                    case .favorites:
                        FavoritesView()
                    case .profile:
                        ProfileView()
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            CustomTabBar(selectedTab: $tabSelection)
            
        }
        .background(Color.digidexBackground.ignoresSafeArea())
       
    }
}


