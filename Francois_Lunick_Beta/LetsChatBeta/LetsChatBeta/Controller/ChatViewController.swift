//
//  ChatViewController.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/16/21.
//

import UIKit
import Firebase
import FirebaseAuth

private let reuseIdentifier = "cell_id00"

class ChatViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    private var conversations = [Conversation]()
    private var users = [User]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NewMessageViewController().delegate = self

        configureUI()
        authenticateUser()
        fetchConversations()
        
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
            self.performSegue(withIdentifier: "ToSignUp", sender: self)
        }
    }
    
    // MARK: - API
    func fetchConversations() {
        Service.fetchConversations { conversations in
            
            self.conversations = conversations
            self.tableView.reloadData()
        }
    }
    
    func authenticateUser() {
        
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {
            print("DEBUG: User is logged in. Configure Controller...")
        }
    }
    
//    func logout() {
//        do {
//            try Auth.auth().signOut()
//            presentLoginScreen()
//        } catch {
//            print("DEBUG: Error signing out..")
//        }
//    }
    
    // MARK: - Actions
    @IBAction func presentNewMessage(_ sender: UIBarButtonItem) {
        
//        let controller = NewMessageViewController()
//        let nav = UINavigationController(rootViewController: controller)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true, completion: nil)
        
        performSegue(withIdentifier: "ToNewMessage", sender: self)
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ChatTableViewCell else {
            
            return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        }
        
        cell.nameLabel.text = conversations[indexPath.row].user.name
        cell.messageLabel.text = conversations[indexPath.row].message.text
        
        let date = conversations[indexPath.row].message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        cell.timeLabel.text = dateFormatter.string(from: date)
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let chat = self.storyboard?.instantiateViewController(identifier: "ChatNav") as? UINavigationController else {
            return
        }
        
        guard let collectionView = chat.viewControllers.first as? ChatCollectionViewController else {
            return
        }
        
        collectionView.user = conversations[indexPath.row].user
        self.present(chat, animated: true, completion: nil)
    }
    
}

// MARK: - NewMessageControllerDelegate
extension ChatViewController: NewMessageControllerDelegate {
    
    func controller(_ controller: NewMessageViewController, user: User) {
        
        //controller.delegate = self
        
        print("DEBUG: \(user.name)")
        //controller.dismiss(animated: true, completion: nil)
    }
}
