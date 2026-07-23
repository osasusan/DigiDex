//
//  BadgesView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//


import SwiftUI

    /// Badge de texto con fondo de color translúcido y borde del mismo color.
    /// Se usa para nivel, atributo, y roles (protagonista/antagonista).
struct BadgeView: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .foregroundStyle(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(color.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(color.opacity(0.4), lineWidth: 0.5)
            )
    }
}

    /// Pill estática (sin selección), usada para debilidades en el detalle.
struct PillView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.footnote.weight(.medium))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.digidexCard)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(Color.digidexBorder, lineWidth: 0.5)
            )
    }
}

    /// Pill seleccionable, usada en los filtros de nivel de la DigiDex.
    /// Cuando está seleccionada se rellena en ámbar (color "activo" de la app);
    /// cuando no, se muestra en el estilo neutro de `PillView`.
struct FilterPillView: View {
    let text: String
    let isSelected: Bool
    
    var body: some View {
        Text(text)
            .font(.footnote.weight(.semibold))
            .foregroundStyle(isSelected ? Color.digidexBackground : .white)
            .padding(.horizontal, 14)
            .padding(.vertical, 7)
            .background(isSelected ? Color.digidexAmber : Color.digidexCard)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(isSelected ? Color.clear : Color.digidexBorder, lineWidth: 0.5)
            )
    }
}


struct vistaPrevia :View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                PillView(text: "Fuego")
                PillView(text: "Hielo")
                PillView(text: "Viento")
                PillView(text: "Psíquico")
                PillView(text: "Lucha")
                PillView(text: "Hada")
                PillView(text: "Bicho")
                PillView(text: "Fantasma")
            }
        }
        .padding()
        
        HStack {
            FilterPillView(text: "Fácil", isSelected: true)
            FilterPillView(text: "Medio", isSelected: false)
            FilterPillView(text: "Difícil", isSelected: true)
        }
        .padding()
        HStack {
            BadgeView(text: "Fuego", color: .digidexAmber)
            BadgeView(text: "Hielo", color: Color.digidexBlue)
        }
    }
}
#Preview {
    vistaPrevia()
}
