//
//  JSONLoader.swift
//  DigiDex
//
//  Created by Osasu sanchez on 21/07/2026.
//

import Foundation

enum JSONLoader {
    
    static func load<T: Decodable>(_ type: T.Type, from fileName: String) throws -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw JSONLoaderError.fileNotFound(fileName)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch let error as JSONLoaderError {
            throw error
        } catch {
            throw JSONLoaderError.decodingFailed(error)
        }
    }
}




enum JSONLoaderError: Error, LocalizedError {
    case fileNotFound(String)
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound(let name):
            return "No se ha encontrado el archivo '\(name)' en el bundle de la app."
        case .decodingFailed(let error):
            return "Error al decodificar el JSON: \(error.localizedDescription)"
        }
    }
}
