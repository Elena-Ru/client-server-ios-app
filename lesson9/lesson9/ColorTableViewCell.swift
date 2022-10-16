//
//  ColorTableViewCell.swift
//  lesson9
//
//  Created by Елена Русских on 15.10.2022.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    @IBOutlet weak var color: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
