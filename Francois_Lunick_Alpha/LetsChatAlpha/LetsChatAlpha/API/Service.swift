//
//  Service.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/19/21.
//

import FirebaseFirestore


struct Service {
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ doc in
                
                let dictionary = doc.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }
}
