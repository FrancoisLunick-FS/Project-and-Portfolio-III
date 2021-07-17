//
//  RegistrationViewController.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/16/21.
//

import UIKit
import Firebase

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
        
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        
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
