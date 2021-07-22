//
//  NewMessageViewController.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/19/21.
//

import UIKit

class NewMessageViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    weak var delegate: NewMessageControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchUsers()
        
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemPink
        
        tableView.rowHeight = 80
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.title = "New Message"
        navigationController?.navigationBar.tintColor = .black
    }
    
    // MARK: - API
    func fetchUsers() {
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    @IBAction func dismissScreen(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource
extension NewMessageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id01", for: indexPath) as? UserTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "cell_id01", for: indexPath)
        }
        
        cell.nameLabel.text = users[indexPath.row].name
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension NewMessageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.dismiss(animated: true, completion: nil)
        
        //let user: User
        //let chat = ChatCollectionViewController(user: user)
        
        //navigationController?.pushViewController(ChatCollectionViewController(), animated: true)
        
        guard let chat = self.storyboard?.instantiateViewController(identifier: "ChatController") as? ChatCollectionViewController else {
            return
        }
        chat.user = users[indexPath.row]
        self.present(chat, animated: true, completion: nil)
        
        //delegate?.controller(self, user: users[indexPath.row])
    }
}
