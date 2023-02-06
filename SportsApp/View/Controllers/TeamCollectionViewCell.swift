//
//  TeamCollectionViewCell.swift
//  SportsApp
//
//  Created by Ahmad Ayman Mansour on 07/02/2023.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib{
    return UINib(nibName: "TeamCollectionViewCell", bundle: nil)
    }

}
