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
 
    
    var searchsText: String = ""
    var selectLrvel: Set<DigimonLevel> = []
    
    
    private let store: DigimonStore
    
    init(store: DigimonStore) {
        self.store = store
    }
    
    /// filtro que encaso de no haver nada selecionado devuelve todos los digimosn
    var filteredDigimon: [Digimon] {
        store.allDigimon.filter { digimon in
            let matchSearchText = self.searchsText.isEmpty || digimon.name.localizedCaseInsensitiveContains(self.searchsText)
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




