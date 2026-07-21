//
//  SagaCardView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct SagaCardView: View {
    let saga: Saga
    let isExpanded: Bool
    let featuredEntries: [(featured: FeaturedDigimon, digimon: Digimon)]
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
                // Acento lateral: distingue cada saga a simple vista (azul, ámbar, rojo, verde).
            Rectangle()
                .fill(saga.accentColor)
                .frame(width: 4)

            VStack(alignment: .leading, spacing: 0) {
                header

                if isExpanded {
                    featuredList
                        .padding(.leading, 20)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                }
            }
        }
        .digidexCardStyle()
    }
    
    private var header: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack{
                        SagaLogoView(saga: saga, height: 26)
                        
                            .font(.headline)
                            .foregroundStyle(Color.digidexBlue)
                    }
                    Text("Temporada \(saga.season) · \(String(saga.year))")
                        .font(.caption)
                        .foregroundStyle(Color.digidexTextSecondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.digidexTextSecondary)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
            }
            .padding(.leading, 20)
            .padding(.trailing, 16)
            .padding(.vertical, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    private var featuredList: some View {
        VStack(spacing: 8) {
            ForEach(Array(featuredEntries.enumerated()), id: \.element.digimon.id) { index, entry in
                NavigationLink(value: entry.digimon) {
                  
                    DigimonRow(digimon: entry.digimon, showRole: entry.featured.role, imageSize: 52)
                }
                .buttonStyle(.plain)
                .transition(.move(edge: .top).combined(with: .opacity))
                    // Cascada: cada fila anima con un pequeño retraso respecto a la anterior.
                .animation(.spring().delay(Double(index) * 0.08), value: isExpanded)
            }
        }
    }
}


