//
//  MessageViewModel.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/21/21.
//

import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        
        return message.isCurrentUser ? .lightGray : .systemBlue
    }
    
    var messageTextColor: UIColor {
        return message.isCurrentUser ? .black : .white
    }
    
    init(message: Message) {
        self.message = message
    }
}
