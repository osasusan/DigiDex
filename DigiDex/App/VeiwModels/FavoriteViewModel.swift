//
//  FavoriteViewModel.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import Foundation

@MainActor
@Observable final class FavoriteViewModel{
    private(set)var favoriteIDs: Set<Int> = []
    
    private let store: DigimonStore
    private var userID: String = ""
    private var defaultKey :String{
        "digidex.favorite\(userID)"
    }
    
    init(store: DigimonStore) {
        self.store = store
        
    }
    func setCurrentUserID(_ iDs: UUID?) {
        userID = iDs?.description ?? ""
        loadFromFavorites()
    }
    var favoriteDigimon : [Digimon] {
        store.allDigimon.filter{favoriteIDs.contains($0.id)}
    }
    func isFavorite(_ digimon: Digimon) -> Bool {
        favoriteIDs.contains(digimon.id)
    }
    
    func toggleFavorite(_ digimon: Digimon) {
        if favoriteIDs.contains(digimon.id) {
            favoriteIDs.remove(digimon.id)
        } else {
            favoriteIDs.insert(digimon.id)
        }
        saveToDefaults()
    }
    private func saveToDefaults() {
        UserDefaults.standard.set(favoriteIDs.sorted(), forKey: defaultKey)
    }
    
    private func loadFromFavorites() {
        let savedIDs = UserDefaults.standard.array(forKey: defaultKey) as? [Int] ?? []
        favoriteIDs = Set(savedIDs)
    }
}
