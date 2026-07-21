//
//  DigimonStore.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import Foundation

@MainActor
@Observable final class DigimonStore{
    private(set) var allDigimon: [Digimon] = []
    private(set) var sagas:[Saga] = []
    private(set) var loadErrors: String?
    
    init(){
        load()
    }
    func load(){
        do {
            allDigimon = try JSONLoader.load([Digimon].self,from: "digimon")
            sagas = try JSONLoader.load([Saga].self,from: "sagas")
            loadErrors = nil
        }catch {
                loadErrors = error.localizedDescription
            }
        }
    
    func digimon(withId id: Int) -> Digimon? {
        allDigimon.first { $0.id == id }
    }
    
    func digimon(named name: String) -> Digimon? {
        allDigimon.first { $0.name == name }
    }
    
    func digimon(named names: [String]) -> [Digimon] {
        names.compactMap { digimon(named: $0) }
    }
}
