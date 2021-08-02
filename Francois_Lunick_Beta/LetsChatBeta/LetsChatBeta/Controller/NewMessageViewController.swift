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
    private var filteredUsers = [User]()
    weak var delegate: NewMessageControllerDelegate?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
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
        configureSearchController()
    }
    
    func configureNavigationBar() {
        
        navigationItem.title = "New Message"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
    }
    
    func configureSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for user"
        definesPresentationContext = false
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            
            textField.textColor = .black
            textField.backgroundColor = .white
        }
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
        
        guard let chat = self.storyboard?.instantiateViewController(identifier: "ChatNav") as? UINavigationController else {
            return
        }
        
        guard let collectionView = chat.viewControllers.first as? ChatCollectionViewController else {
            return
        }
        
        collectionView.user = users[indexPath.row]
        self.present(chat, animated: true, completion: nil)
        
        //delegate?.controller(self, user: users[indexPath.row])
    }
}

extension NewMessageViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filteredUsers = users.filter({ user in
            
            return user.name.contains(searchText)
        })
    }
    
    
}
