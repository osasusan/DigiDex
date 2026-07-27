//
//  DigimonImageView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct DigimonImageView: View {
    let digimon: Digimon
    var size: CGFloat = 125
    var cornerRadius: CGFloat = 12
    
    var body: some View {
        Group {
            if UIImage(named: digimon.image) != nil {
                Image(digimon.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            } else {
                placeholder
            }
        }
        .frame(width: size, height: size)
    }
    
    private var placeholder: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(digimon.level.badgeColor.opacity(0.15))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(digimon.level.badgeColor.opacity(0.4), lineWidth: 0.5)
            )
            .overlay(
                Text(String(digimon.name.prefix(2)).uppercased())
                    .font(.system(size: size * 0.28, weight: .bold))
                    .foregroundStyle(digimon.level.badgeColor)
            )
    }
}

#Preview {
    DigimonImageView(digimon: .previews)
}

