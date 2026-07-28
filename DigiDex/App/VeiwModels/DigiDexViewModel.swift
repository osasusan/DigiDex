    //
    //  DigiDexViewModel.swift
    //  DigiDex
    //
    //  Created by Osasu sanchez on 10/07/2026.
    //

import Foundation
import Observation

@MainActor
@Observable final class DigiDexViewModel{
        //    private (set) var AllDigimon: [Digimon] = []
        //    private (set)var sagas:[Saga] = []
        //    private (set)var loadErrors: String?
        //
    
    var searchText: String = ""
    var selectLrvel: Set<DigimonLevel> = []
    
    
    private let store: DigimonStore
    
    init(store: DigimonStore) {
        self.store = store
    }
    
    /// filtro que encaso de no haver nada selecionado devuelve todos los digimosn
    var filteredDigimon: [Digimon] {
        store.allDigimon.filter { digimon in
            let matchSearchText = self.searchText.isEmpty || digimon.name.localizedCaseInsensitiveContains(self.searchText)
            let matchLevel = self.selectLrvel.isEmpty || self.selectLrvel.contains(digimon.level)
            return matchSearchText && matchLevel
        }
    }
    func isSelcted(level: DigimonLevel) -> Bool {
        selectLrvel.contains(level)
    }
    
    ///añado o quito filtord de busquedad de nivel 
    func toggleLevel(level: DigimonLevel) {
        if selectLrvel.contains(level){
            selectLrvel.remove(level)
        }else{
            selectLrvel.insert(level)
        }
    }
}




