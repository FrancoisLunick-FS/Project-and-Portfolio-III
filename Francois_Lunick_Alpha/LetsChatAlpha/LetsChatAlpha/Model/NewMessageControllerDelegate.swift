//
//  NewMessageControllerDelegate.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/19/21.
//

import Foundation

protocol NewMessageControllerDelegate: AnyObject {
    func controller(_ controller: NewMessageViewController, user: User)
}
