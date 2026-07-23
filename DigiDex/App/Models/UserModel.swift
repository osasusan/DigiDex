//
//  UserModel.swift
//  DigiDex
//
//  Created by Osasu sanchez on 10/07/2026.
//

import Foundation

struct UserModel: Codable, Equatable {
    var username: String
    var email: String
    var passwordHash: String
        /// Foto de perfil guardada como Data (JPEG) para poder persistirla en UserDefaults.
    var profileImageData: Data?
}

