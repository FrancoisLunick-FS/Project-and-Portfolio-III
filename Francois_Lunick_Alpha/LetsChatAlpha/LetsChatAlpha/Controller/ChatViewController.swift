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

        configureUI()
        authenticateUser()
        
    }
    
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
        DispatchQueue.main.async {
            let controller = LoginViewController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            
            self.present(nav, animated: true, completion: nil)
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
            
        } catch {
            print("DEBUG: Error signing out..")
        }
    }
    
    // MARK: - Actions
    @IBAction func presentNewMessage(_ sender: UIBarButtonItem) {
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
