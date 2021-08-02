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
        
        return message.isCurrentUser ? #colorLiteral(red: 0.7926014066, green: 0.893353045, blue: 0.7261243463, alpha: 1) : #colorLiteral(red: 0.4, green: 0.7215686275, blue: 0.1294117647, alpha: 1)
    }
    
    var messageTextColor: UIColor {
        return message.isCurrentUser ? .black : .white
    }
    
    var rightAnchorActive: Bool {
        return message.isCurrentUser
    }
    
    var leftAnchorActive: Bool {
        return !message.isCurrentUser
    }
    
    var shouldHideProfileImage: Bool {
        return message.isCurrentUser
    }
    
    init(message: Message) {
        self.message = message
    }
}
