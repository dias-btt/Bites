//
//  LoginViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 01.04.2024.
//

import Foundation
import Firebase
import GoogleSignIn

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
    func signInGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) {user, error in
            if let error = error {
                print(error.localizedDescription)
              return
          }

          guard let user = user?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) {res, error in
                if let error = error {
                    print(error.localizedDescription)
                  return
              }
                guard let user = res?.user else {return}
                print("Here is the user from Google \(user)")
                AuthService.shared.userSession = user
                                
                Task {
                    try await AuthService.shared.loadUser()
                }
            }
        }
    }
}
