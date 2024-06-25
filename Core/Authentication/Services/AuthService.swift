//
//  AuthService.swift
//  Bites
//
//  Created by Диас Сайынов on 01.04.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase
import GoogleSignIn

class AuthService{
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init(){
        Task {try await loadUser()}
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUser()
        }catch{
            print("DEBUG: Failed to register user \(error)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, name: String, birthDate: Date, country: String, city: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("Uploading data of user...")
            await self.uploadData(uid: result.user.uid, name: name, email: email, birthDate: birthDate, country: country, city: city)
        }catch{
            print("DEBUG: Failed to register user \(error)")
        }
    }
    
    @MainActor
    func loadUser() async throws{
        self.userSession = Auth.auth().currentUser
        guard let currentUID = userSession?.uid else {return}
        self.currentUser = try await UserService.fetchUser(withUid: currentUID)
    }
    
    func signout(){
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else { return }
        let userId = user.uid
        
        try? await Firestore.firestore().collection("users").document(userId).delete()
        try await user.delete()
        
        self.userSession = nil
        self.currentUser = nil
    }
    
    private func uploadData(uid: String, name: String, email: String, birthDate: Date, country: String, city: String) async {
        let user = User(id: uid, email: email, name: name, birthDate: birthDate, country: country, city: city, bonuses: 0)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        print("User uploaded")
    }
}
