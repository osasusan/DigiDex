    //
    //  DigiDexApp.swift
    //  DigiDex
    //
    //  Created by Osasu sanchez on 09/06/2026.
    //

import SwiftUI

@main
struct DigiDexApp: App {
    @State private var store:DigimonStore
    @State private var favorites :FavoriteViewModel
    
    init() {
        let store = DigimonStore()
        _store = State(initialValue: store)
        _favorites = State(initialValue: FavoriteViewModel(store: store))
    }
    var body: some Scene {
        WindowGroup {
            mainTabView()
                .environment(store)
                .environment(favorites)
                .preferredColorScheme(.dark)
        }
    }
}
