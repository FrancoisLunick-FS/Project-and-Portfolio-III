//
//  ViewController.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/5/21.
//

import UIKit

private let reuseIdentifier = "ChatCell"

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
        
        // MARK: - Properties
        var user: User!
        private var messages = [Message]()
        var fromCurrentUser = false
        
        private lazy var customInputView: CustomInputAccessoryView = {
            let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
            
            //iv.delegate = self
            
            return iv
        }()

        // MARK: - View Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            let rootViewController = self
            let chatNavigationController = UINavigationController(rootViewController: rootViewController)
            
            //print(user.name)
            //navigationController?.title = user.name
            //navigationController?.navigationBar.tintColor = .black
            
            chatNavigationController.title = "sss"
            let appearance = UINavigationBarAppearance()
            //appearance.configureWithOpaqueBackground()
            //appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = .systemPurple
            
            chatNavigationController.navigationBar.standardAppearance = appearance
            chatNavigationController.navigationBar.compactAppearance = appearance
            chatNavigationController.navigationBar.scrollEdgeAppearance = appearance
            
            chatNavigationController.navigationBar.prefersLargeTitles = true

            chatNavigationController.navigationBar.tintColor = .white
            //chatNavigationController.navigationBar.isTranslucent = true
            
            //chatNavigationController.navigationBar.overrideUserInterfaceStyle = .dark
            //navigationController?.navigationBar.isTranslucent = true
            //navigationController?.navigationBar.prefersLargeTitles = true
            

            // Register cell classes
            self.collectionView!.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

            // Do any additional setup after loading the view.
            
            collectionView.backgroundColor = .white
            collectionView.alwaysBounceVertical = true
            collectionView.keyboardDismissMode = .interactive
            
            //fetchMessages()
        }
        
        override var inputAccessoryView: UIView? {
            get { return customInputView }
        }

        override var canBecomeFirstResponder: Bool {
            
            return true
        }
        
//        // MARK: - API
//        func fetchMessages() {
//            Service.fetchMessages(forUser: user) { messages in
//                self.messages = messages
//
//                self.collectionView.reloadData()
//                self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
//            }
//        }
        
    //    init(user: User) {
    //        self.user = user
    //        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
        
        

        // MARK: - UICollectionViewDelegate

        /*
        // Uncomment this method to specify if the specified item should be highlighted during tracking
        override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
            return true
        }
        */

        /*
        // Uncomment this method to specify if the specified item should be selected
        override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
            return true
        }
        */

        /*
        // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
        override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
            return false
        }

        override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
            return false
        }

        override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
        }
        */

    }

    // MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of items
            return messages.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MessageCollectionViewCell else {
                
                return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            }
            
            // Configure the cell
            cell.message = messages[indexPath.row]
            cell.message?.user = user
            
            return cell
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    extension ViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            
            return .init(top: 16, left: 0, bottom: 16, right: 0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            let estimatedSizeCell = MessageCollectionViewCell(frame: frame)
            estimatedSizeCell.message = messages[indexPath.row]
            estimatedSizeCell.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 1000)
            let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        }
    }

//    extension ViewController: CustomInputAccessoryViewDelegate {
//
//        func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
//
//            Service.uploadMessage(message, to: user) { error in
//
//                if let error = error {
//                    print("DEBUG: Failed to upload message with error \(error.localizedDescription)")
//
//                    return
//                }
//
//                inputView.clearMessageText()
//            }
//
//            //fromCurrentUser.toggle()
//
//    //        let message = Message(text: message, isCurrentUser: fromCurrentUser)
//    //        messages.append(message)
//            //collectionView.reloadData()
//        }
//    }




