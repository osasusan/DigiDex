//
//  FavoriteCardView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 22/07/2026.
//

import SwiftUI

struct FavoriteCardView: View {
    let digimon: Digimon
    
    var body: some View {
        VStack (spacing: 5){
            DigimonImageView(digimon: digimon,size: 90,cornerRadius: 20)
            Text(digimon.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.white)
                .lineLimit(1)
            
            BadgeView(text: digimon.level.rawValue, color: digimon.level.badgeColor)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .digidexCardStyle()
    }
}

#Preview {
    FavoriteCardView(digimon : .previews1)
}
