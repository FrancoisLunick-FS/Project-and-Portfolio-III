//
//  ChatViewController.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/16/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NewMessageViewController().delegate = self

        configureUI()
        authenticateUser()
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.dismiss(animated: true) {
//            super.viewWillDisappear(true)
//        }
//    }
    
    // MARK: - Helpers
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Chats"
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.isTranslucent = true
//
//        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        
        configureTableView()
        
    }
    
    func configureTableView() {
        tableView.rowHeight = 80
        
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
    func authenticateUser() {
        
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {
            print("DEBUG: User is logged in. Configure Controller...")
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
    @IBAction func presentNewMessage(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "ToNewMessage", sender: self)
    }
    
    @IBAction func exitScreen(_ sender: UIBarButtonItem) {
        logout()
    }
    
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id00", for: indexPath)
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    
}

// MARK: - NewMessageControllerDelegate
extension ChatViewController: NewMessageControllerDelegate {
    
    func controller(_ controller: NewMessageViewController, user: User) {
        
        print("DEBUG: \(user.name)")
        //controller.dismiss(animated: true, completion: nil)
    }
}
