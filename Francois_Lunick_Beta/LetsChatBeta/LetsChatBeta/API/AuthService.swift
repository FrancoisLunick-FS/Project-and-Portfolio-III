//
//  AuthService.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/19/21.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

struct RegistrationCredentials {
    
    let name: String
    let email: String
    let password: String
}

struct AuthService {
    static let shared = AuthService()
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
            
            if let error = error {
                
                completion!(error)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let data = [ "name": credentials.name,
                         "email": credentials.email,
                         "uid": uid,
                         "password": credentials.password] as [String: Any]
            
            Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
        }
    }
    
    func logInUser(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
