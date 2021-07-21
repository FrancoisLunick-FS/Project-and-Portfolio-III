//
//  CustomInputAccessoryView.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/21/21.
//

import UIKit

class CustomInputAccessoryView: UIView {

    // MARK: - Properties
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        autoresizingMask = .flexibleHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
