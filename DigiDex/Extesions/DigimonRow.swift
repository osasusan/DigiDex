//
//  DigimonRow.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI
///Fila de la lista de la DigiDex: imagen, nombre, tipo y badge de nive o rol.
struct DigimonRow: View {
    let digimon: Digimon
    
    var showRole: FeaturedRole? = nil
    var imageSize: CGFloat = 52
    var cornerRadius: CGFloat = 10
    var body: some View {
           
        
        HStack(spacing: 12) {
            DigimonImageView(digimon: digimon, size: imageSize, cornerRadius: cornerRadius)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(digimon.name)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                
                Text(showRole != nil ? digimon.level.rawValue : digimon.type)
                    .font(.caption)
                    .foregroundStyle(Color.digidexTextSecondary)
            }
            
            Spacer()
            
                // Si hay rol lo muestra, si no muestra el nivel
            if let role = showRole {
                BadgeView(text: role.label, color: role.badgeColor)
            } else {
                BadgeView(text: digimon.level.rawValue, color: digimon.level.badgeColor)
            }
        }
        .padding(10)
        .digidexCardStyle(cornerRadius: cornerRadius)
    }
}
#if DEBUG
extension Digimon {
    static let previews = Digimon(
        id: 3,
        name: "Agumon",
        level: .rookie,
        attribute: .virus,
        type: "Reptile",
        description: "Pequeño Digimon reptil con gran potencial evolutivo.",
        image: "agumon",
        weaknesses: ["Virus", "Agua"],
        evolvesFrom: ["Koromon"],
        evolvesTo: ["Greymon"]
    )
}
#endif
#Preview {
    ZStack {
        
        Color.digidexBackground.ignoresSafeArea()
        VStack(spacing: 10) {
                // Caso 1: lista DigiDex (sin rol)
            DigimonRow(digimon: .previews)
            
                // Caso 2: Home saga protagonista
            DigimonRow(digimon: .previews, showRole: .protagonist, imageSize: 40)
            
                // Caso 3: Home saga antagonista
            DigimonRow(digimon: .previews, showRole: .antagonist, imageSize: 40)
        }
        .padding()
        .background(Color.digidexCard)
    }
}
