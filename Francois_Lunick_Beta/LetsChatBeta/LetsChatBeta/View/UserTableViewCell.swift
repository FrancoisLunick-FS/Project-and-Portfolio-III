//
//  UserTableViewCell.swift
//  LetsChatAlpha
//
//  Created by Lunick Francois on 7/19/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
