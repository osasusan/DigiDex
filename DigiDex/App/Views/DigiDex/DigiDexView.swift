//
//  DigiDexView.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import SwiftUI

struct DigiDexView: View {
    @Environment(DigiDexViewModel.self)private var viewModel
    
    
    var body: some View {
        @Bindable var vm = viewModel
        NavigationStack {
            
            VStack(spacing: 10) {
                
                LevelFilterBar()
                
                if viewModel.filteredDigimon.isEmpty {
                    Spacer()
                    Text("No se encuentra ningun digimon")
                        .font(.subheadline)
                        .foregroundColor(.digidexTextSecondary)
                    Spacer()
                }else{
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.filteredDigimon) { digimon in
                                NavigationLink(value: digimon){
                                    DigimonRow(digimon: digimon)
                                }
                            }
                        }
                    }
                }
            }
            
            .padding(.horizontal,15)
            .padding(.top,10)
            .background(Color.digidexBackground.ignoresSafeArea())
            .navigationTitle(Text("DigiDex"))
            .searchable(text: $vm.searchsText ,prompt: "Buscar Digimon")
            .navigationDestination(for: Digimon.self) { digimon in
                DigimonDetailView(digimon: digimon)
            }
        }
    }
}


struct LevelFilterBar: View {
    @Environment(DigiDexViewModel.self) private var viewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(DigimonLevel.orderedCases) { level in
                    Button{
                        viewModel.toggleLevel(level: level)
                    }label: {
                        FilterPillView(text: level.rawValue, isSelected: viewModel.isSelcted(level: level))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal,10)
        }
    }
}

#Preview {
    DigiDexView()
        .environment(DigiDexViewModel(store: DigimonStore()))
}

#Preview("Filtros"){
    
    LevelFilterBar()
        .environment(DigiDexViewModel(store: DigimonStore()))
}
