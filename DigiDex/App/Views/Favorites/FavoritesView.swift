//
//  FavoritesView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(FavoriteViewModel.self) private var vm
    
    private let columnas = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        NavigationStack{
            Group{
                if vm.favoriteDigimon.isEmpty {
                    vacioFv()
                }else {
                    ScrollView{
                        LazyVGrid(columns: columnas, spacing: 12) {
                            ForEach(vm.favoriteDigimon) { digimon in
                                NavigationLink( value: digimon){
                                    FavoriteCardView(digimon: digimon)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(14)
                    }
                }
            }
            .background(Color.digidexBackground.ignoresSafeArea())
            .navigationBarTitle("Favoritos")
            .navigationDestination(for: Digimon.self) { digimon in
                DigimonDetailView(digimon: digimon)
            }
        }
    }
    func vacioFv() -> some View {
        VStack(spacing: 10){
            Image(systemName: "heart.slash")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color.digidexTextSecondary)
            
            Text("Todavía no tienes favoritos")
                .font(.title3)
            
                .fontWeight(.bold)
                .foregroundStyle(Color.digidexTextSecondary)
                .multilineTextAlignment(.center)
            
            Text("Agrega un Digimon a tus favoritos marcando el corzón")
                .font(.caption)
                .foregroundStyle(Color.digidexTextSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(32)
    }
}

#Preview {
    FavoritesView()
        .environment(FavoriteViewModel(store: DigimonStore()))
    
}
