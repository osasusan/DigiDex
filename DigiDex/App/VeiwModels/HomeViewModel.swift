//
//  HomeViewModel.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import Foundation

@MainActor

@Observable final class HomeViewModel {
    
    private var sagasExpansID : Int?
    private let store :DigimonStore
    
    init(store: DigimonStore){
        self.store = store
    }
    
    var sagas: [Saga] {
        store.sagas
    }
    
    func isExpanded(saga:Saga) -> Bool {
        sagasExpansID == saga.id
    }
    func toggle(saga: Saga) {
        sagasExpansID = isExpanded(saga: saga) ? nil : saga.id
    }
    func featuredEntries(for saga: Saga) -> [(featured: FeaturedDigimon, digimon: Digimon)] {
        saga.orderedFeatured.compactMap { featured in
            guard let digimon = store.digimon(withId: featured.digimonId) else { return nil }
            return (featured, digimon)
            
        }
    }
    
}
