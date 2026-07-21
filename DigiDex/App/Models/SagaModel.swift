//
//  SagaModel.swift
//  DigiDex
//
//  Created by Osasu sanchez on 10/07/2026.
//

import Foundation
import SwiftUI

    /// Rol de un Digimon dentro de una saga: protagonista o antagonista.
    /// Determina el color del badge en la lista de destacados del Home.
enum FeaturedRole: String, Codable {
    case protagonist
    case antagonist
    
    var badgeColor: Color {
        switch self {
        case .protagonist: return .digidexBlue
        case .antagonist: return .digidexRed
        }
    }
    
    var label: String {
        switch self {
        case .protagonist: return "Protagonista"
        case .antagonist: return "Antagonista"
        }
    }
}

    /// Referencia a un Digimon destacado dentro de una saga.
    /// Solo guarda el `digimonId` (no el Digimon completo): es el ViewModel
    /// quien cruza este id con la lista completa de Digimon para obtener la ficha.
struct FeaturedDigimon: Codable, Hashable {
    let digimonId: Int
    let role: FeaturedRole
    let order: Int
}

    /// Una saga de Digimon (Adventure, Adventure 02, Tamers, Frontier...).
struct Saga: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let season: Int
    let logo: String
    let year: Int
    let featured: [FeaturedDigimon]
    
        /// Los destacados ordenados por su campo `order`, listos para pintar en cascada.
    var orderedFeatured: [FeaturedDigimon] {
        featured.sorted { $0.order < $1.order }
    }
}

    /// Color de acento lateral por saga. No viene en el JSON porque es puramente
    /// visual, así que lo resolvemos aquí a partir del `id` de la saga.
    /// El orden fijo es: Adventure = azul, Adventure 02 = ámbar, Tamers = rojo, Frontier = verde.
extension Saga {
    var accentColor: Color {
        switch id {
        case 1: return Color.digidexBlue
        case 2: return Color.digidexAmber
        case 3: return Color.digidexRed
        case 4: return Color.digidexGreen
        default: return Color.digidexBlue
        }
    }
}
