//
//  DigimonsModel.swift
//  DigiDex
//
//  Created by Osasu sanchez on 10/07/2026.
//


import SwiftUI

/// Modelo principal de la app. Representa una ficha completa de Digimon

/// - `evolvesFrom` / `evolvesTo` guardan NOMBRES de Digimon (no ids), tal como
///   vienen en el JSON. Es el ViewModel el que resuelve esos nombres a objetos
///   `Digimon` completos cuando el usuario navega a esa ficha.
/// - Es `Hashable` porque `NavigationStack` necesita poder usarlo como valor
///   dentro del `NavigationPath` para la navegación recursiva entre fichas.

struct Digimon: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let level: DigimonLevel
    let attribute: DigimonAttribute
    let type: String
    let description: String
    let image: String
    let weaknesses: [String]
    let evolvesFrom: [String]
    let evolvesTo: [String]
}
enum DigimonLevel: String, Codable, CaseIterable, Identifiable {
    case fresh = "Fresh"
    case inTraining = "In-Training"
    case rookie = "Rookie"
    case champion = "Champion"
    case ultimate = "Ultimate"
    case mega = "Mega"
    
    var id: String { rawValue }
    
        /// Orden evolutivo real (Fresh es el más bajo, Mega el más alto).
    static var orderedCases: [DigimonLevel] {
        [.fresh, .inTraining, .rookie, .champion, .ultimate, .mega]
    }
    
        /// Color del badge de nivel, según la paleta de la app.
    var badgeColor: Color {
        switch self {
        case .fresh, .inTraining:
            return .digidexTextSecondary
        case .rookie:
            return .digidexGreen
        case .champion:
            return .digidexBlue
        case .ultimate:
            return .digidexAmber
        case .mega:
            return .digidexRed
        }
    }
}

    
enum DigimonAttribute: String, Codable, CaseIterable {
    case vaccine = "Vaccine"
    case virus = "Virus"
    case data = "Data"
    
    var id: String { rawValue }
    
        /// A qué atributo le gana este. Útil para mostrar contexto en el detalle
        /// (ej. "Vaccine · fuerte contra Virus").
    var beats: DigimonAttribute {
        switch self {
        case .vaccine: return .virus
        case .virus: return .data
        case .data: return .vaccine
        }
    }
    
    var badgeColor: Color {
        switch self {
        case .vaccine: return .digidexBlue
        case .virus: return .digidexRed
        case .data: return .digidexGreen
        }
    }
}

