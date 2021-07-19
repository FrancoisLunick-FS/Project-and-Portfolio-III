//
//  RegistrationViewController.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/16/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var googleSignUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = 20
        googleSignUpButton.layer.cornerRadius = 20
    }
    
    // MARK: - Actions
    @IBAction func handleNewUser(_ sender: UIButton) {
        
        guard let name = nameTextField.text?.lowercased(),
              let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        let credentials = RegistrationCredentials(name: name, email: email, password: password)
        
        showLoader(true, withText: "Signing In")
        
        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                
                print("DEBUG: Failed to upload user data with error \(error.localizedDescription)")
                
                self.showLoader(false)
                return
            }
            
            self.showLoader(false)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "NewUserToChat", sender: self)
            }
        }
        
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            
//            if let error = error {
//                
//                print("DEBUG: Failed to create user with error \(error.localizedDescription)")
//                return
//            }
//            
//            guard let uid = result?.user.uid else { return }
//            
//            let data = [ "name": name,
//                         "email": email,
//                         "uid": uid,
//                         "password": password] as [String: Any]
//            
//            Firestore.firestore().collection("users").document(uid).setData(data) { error in
//                if let error = error {
//                    
//                    print("DEBUG: Failed to upload user data with error \(error.localizedDescription)")
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "NewUserToChat", sender: self)
//                }
//            }
//        }
    }
}
