//
//  ProfileViewController.swift
//  LetsChatBeta
//
//  Created by Lunick Francois on 7/22/21.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    private var user: User?
    
    @IBOutlet var ViewCollection: [UIView]!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        fetchUser()
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        for view in ViewCollection {
            
            view.layer.cornerRadius = 15
        }
    }
    
    func presentLoginScreen() {
//        DispatchQueue.main.async {
//            let controller = LoginViewController()
//            let nav = UINavigationController(rootViewController: controller)
//            //self.definesPresentationContext = true
//            nav.modalPresentationStyle = .fullScreen
//
//            //let appDelegate = UIApplication.shared.delegate as? AppDelegate
//            //appDelegate?.window?.rootViewController?.present(nav, animated: true, completion: nil)
//            self.present(nav, animated: true, completion: nil)
//
////            let viewController = LoginViewController().children.first
////            viewController?.modalPresentationStyle = .fullScreen
////            viewController?.modalTransitionStyle = .coverVertical
////            viewController?.presentingViewController?.dismiss(animated: true, completion: nil)
//
//        }
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ToSignUpSplash", sender: self)
        }
    }
    
    // MARK: - API
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Service.fetchUser(withUid: uid) { user in
            self.user = user
            
            self.nameLabel.text = user.name
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("DEBUG: Error signing out..")
        }
    }
    
    // MARK: - Actions
    @IBAction func signUserOut(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: "Are you sure you want to sign out", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { UIAlertAction in
            
            self.logout()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
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
