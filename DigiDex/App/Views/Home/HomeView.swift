    //
    //  HomeView.swift
    //  DigiDex
    //
    //  Created by Osasu sanchez on 14/06/2026.
    //

import SwiftUI

struct HomeView: View {
    @Environment(HomeViewModel.self) private var viewModel
  
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 16){
                    ForEach(viewModel.sagas){ saga in
                        SagaCardView(
                            saga: saga,
                            isExpanded: viewModel.isExpanded(saga: saga),
                            featuredEntries: viewModel.featuredEntries(for: saga),
                            onTap: {
                                withAnimation(.spring()) {
                                    viewModel.toggle(saga: saga)
                                }
                                  
                            }
                        )
                    }
                }
                .padding(16)
            }
            .background(Color.digidexBackground.ignoresSafeArea())
            .navigationTitle("Home")
            .navigationDestination(for:Digimon.self){ digimon in
                DigimonDetailView(digimon: digimon)
            }
            
        }
    }
}
//#Preview {
//    HomeView(store: .init())
//        .environment(HomeViewModel())
//}



