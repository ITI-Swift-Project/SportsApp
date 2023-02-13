//
//  PlayerCollectionViewCell.swift
//  SportsApp
//
//  Created by Ahmad Ayman Mansour on 13/02/2023.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerImagView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerAgeLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var yellowCardsLabel: UILabel!
    @IBOutlet weak var redCardsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib{
    return UINib(nibName: "PlayerCollectionViewCell", bundle: nil)
    }
    
}
