//
//  DigimonDetailView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct DigimonDetailView: View {
    let digimon: Digimon
    
    @Environment(DigimonStore.self) private var digimonStore
    @Environment(FavoriteViewModel.self) private var favorites
    
    private var preEvolution: [Digimon] {
        digimonStore.digimon(named: digimon.evolvesFrom)
    }
    private var nextEvolution: [Digimon] {
        digimonStore.digimon(named: digimon.evolvesTo)
        
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                imageHeader
                badgesRow
                descriptionSection
                weaknessesSection
                
                if !preEvolution.isEmpty {
                    evolutionSection(title: "Evolución previa", digimons: preEvolution)
                }
                if !nextEvolution.isEmpty {
                    evolutionSection(title: "Evoluciona a", digimons: nextEvolution)
                }
            }
            .padding(16)
        }
        .background(Color.digidexBackground.ignoresSafeArea())
        .navigationTitle(digimon.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favorites.toggleFavorite(digimon)
                } label: {
                    Image(systemName: favorites.isFavorite(digimon) ? "heart.fill" : "heart")
                        .foregroundStyle(favorites.isFavorite(digimon) ? Color.digidexRed : Color.digidexTextSecondary)
                }
            }
        }
    }
    
    private var imageHeader: some View {
        HStack {
            Spacer()
            DigimonImageView(digimon: digimon, size: 180, cornerRadius: 16)
            Spacer()
        }
    }
    
    private var badgesRow: some View {
        HStack(spacing: 8) {
            BadgeView(text: digimon.level.rawValue, color: digimon.level.badgeColor)
            BadgeView(text: digimon.attribute.rawValue, color: digimon.attribute.badgeColor)
            Spacer()
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(digimon.type.uppercased())
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.digidexTextSecondary)
            
            Text(digimon.description)
                .font(.body)
                .foregroundStyle(.white)
            
                // Pequeño extra sobre la regla piedra-papel-tijera de atributos,
                // ya que la app la modela en `DigimonAttribute.beats`.
            Text("\(digimon.attribute.rawValue) es fuerte contra \(digimon.attribute.beats.rawValue)")
                .font(.caption)
                .foregroundStyle(Color.digidexTextSecondary)
        }
    }
    
    private var weaknessesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Debilidades")
                .font(.headline)
                .foregroundStyle(.white)
            
          
                ForEach(digimon.weaknesses, id: \.self) { weakness in
                    PillView(text: weakness)
                }
        }
    }
    
    private func evolutionSection(title: String, digimons: [Digimon]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
            
            VStack(spacing: 8) {
                ForEach(digimons) { evolution in
                    NavigationLink(value: evolution) {
                        DigimonRow(digimon: evolution)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}



