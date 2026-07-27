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
    @State private var isAuthorized:AuntentificacionViewModel
    @State private var home :HomeViewModel
    
    init() {
        let store = DigimonStore()
        _store = State(initialValue: store)
        _favorites = State(initialValue: FavoriteViewModel(store: store))
        _isAuthorized = State(initialValue: AuntentificacionViewModel())
        _home = State(initialValue: HomeViewModel(store: store))
    }
    var body: some Scene {
        WindowGroup {
            Root()
                .environment(store)
                .environment(favorites)
                .environment(isAuthorized)
                .preferredColorScheme(.dark)
        }
    }
}
