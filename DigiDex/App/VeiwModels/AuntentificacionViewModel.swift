//
//  AuntentificacionViewModel.swift
//  DigiDex
//
//  Created by Osasu sanchez on 22/07/2026.
//

import Foundation
import CryptoKit

@MainActor
@Observable final class AuntentificacionViewModel {
    
    var isAuthenticated = false
    var currentUser: UserModel?
    var errorMessage: String?
    
    private let userDefultsKey = "digidex.registredUser"
    private let sesionDefultsKey = "digidex.loggedUser"
    
    init(){
        reSession()
    }
    
    func login (userName: String ,pass : String){
        
        errorMessage = nil
        guard !userName.isEmpty, !pass.isEmpty else {
            errorMessage = "Todos los campos son requeridos"
            return
        }
        guard let user = registroUser()[userName] else {
            errorMessage = "No existe ninguna cuenta con ese usuario."
            return
        }
        guard user.passwordHash == Self.hash(pass) else {
            errorMessage = "Usuario o contraseña incorrectos"
            return
        }
        currentUser = user
        isAuthenticated = true
        UserDefaults.standard.set(userName, forKey: sesionDefultsKey)
        
    }
    
    func registrer(email:String ,username :String , pass:String , repeatPass:String){
        errorMessage = nil
        guard !email.isEmpty, !username.isEmpty, !pass.isEmpty, !repeatPass.isEmpty else {
            errorMessage = "Todos los campos son requeridos"
            return
        }
        guard pass == repeatPass else {
            errorMessage = "Las contraseñas no coinciden"
            return
        }
        var user = registroUser()
        guard user [username] == nil else {
            errorMessage = "El usuario ya existe"
            return
        }
        
        let newUser = UserModel(username: username, email: email, passwordHash: Self.hash(pass))
        user[username] = newUser
        saveRegisto(user)
        
        currentUser = newUser
        isAuthenticated = true
        UserDefaults.standard.set(username, forKey: sesionDefultsKey)
        
    }
    
    func logout(){
        isAuthenticated = false
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: sesionDefultsKey)
        
    }
    
    func updateProfile(username: String? = nil, newPassword: String? = nil, profileImageData: Data? = nil) {
        guard var user = currentUser else { return }
        var users = registroUser()
        let oldUsername = user.username
        
        if let username, !username.isEmpty {
            user.username = username
        }
        if let newPassword, !newPassword.isEmpty {
            user.passwordHash = Self.hash(newPassword)
        }
        if let profileImageData {
            user.profileImageData = profileImageData
        }
        
        users.removeValue(forKey: oldUsername)
        users[user.username] = user
        saveRegisto(users)
        
        currentUser = user
        UserDefaults.standard.set(user.username, forKey: sesionDefultsKey)
    }
    
    
    private func registroUser() -> [String : UserModel]{
        guard let data = UserDefaults.standard.data(forKey: userDefultsKey),
              let users = try? JSONDecoder().decode([String:UserModel].self, from: data) else {
            return [:]
        }
        return users
    }
    
    private func reSession(){
        guard let username = UserDefaults.standard.string(forKey: sesionDefultsKey),
        let user = registroUser()[username]else {return}
        currentUser = user
        isAuthenticated = true
    }
    private func saveRegisto(_ user: [String:UserModel]){
        guard let data = try? JSONEncoder().encode(user) else {return}
        UserDefaults.standard.set(data, forKey: userDefultsKey)
    }
//    private func saveRegisteredUsers(_ users: [String: UserProfile]) {
//        guard let data = try? JSONEncoder().encode(users) else { return }
//        UserDefaults.standard.set(data, forKey: userDefultsKey)
//    }
    private static func hash(_ text: String) -> String {
        "\(text.hashValue)"
    }
   
    
}
