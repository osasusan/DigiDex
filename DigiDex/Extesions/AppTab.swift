//
//  AppTab.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import Foundation
enum AppTab: CaseIterable {
    case home
    case digidex
    case favorites
    case profile
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .digidex: return "DigiDex"
        case .favorites: return "Favoritos"
        case .profile: return "Perfil"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .digidex: return "list.bullet"
        case .favorites: return "heart.fill"
        case .profile: return "person.fill"
        }
    }
}
