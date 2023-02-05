//
//  TableViewCell.swift
//  SportsApp
//
//  Created by Salma on 04/02/2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var LeagueName: UILabel!
    @IBOutlet weak var LeaugeLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
