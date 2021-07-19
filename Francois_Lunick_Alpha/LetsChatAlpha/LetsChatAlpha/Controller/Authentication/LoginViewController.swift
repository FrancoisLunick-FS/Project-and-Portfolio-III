//
//  LoginViewController.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/16/21.
//

import UIKit
import Firebase
import FirebaseAuth
import JGProgressHUD

class LoginViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        signInButton.layer.cornerRadius = 20
        googleSignInButton.layer.cornerRadius = 20
    }
    
    // MARK: - Actions
    @IBAction func signInUser(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        showLoader(true, withText: "Logging In")
        
        AuthService.shared.logInUser(withEmail: email, password: password) { result, error in
            if let error = error {
                
                print("DEBUG: Failed to log in with error \(error.localizedDescription)")
                
                self.showLoader(false)
                return
            }
            
            self.showLoader(false)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "UserBackToChat", sender: self)
            }
        }
   
        //TODO: UNCOMMENT
//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            if let error = error {
//
//                print("DEBUG: Failed to log in with error \(error.localizedDescription)")
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "UserBackToChat", sender: self)
//            }
//        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
