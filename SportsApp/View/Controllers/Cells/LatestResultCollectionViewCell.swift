//
//  LatestResultCollectionViewCell.swift
//  SportsApp
//
//  Created by Ahmad Ayman Mansour on 06/02/2023.
//

import UIKit

class LatestResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventFinalResultLabel: UILabel!
    @IBOutlet weak var eventHomeTeamNameLabel: UILabel!
    @IBOutlet weak var eventHomeTeamImageView: UIImageView!
    @IBOutlet weak var eventAwayTeamImageView: UIImageView!
    @IBOutlet weak var eventAwayTeamNameLabel: UILabel!
    
    @IBOutlet weak var eventDataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib{
    return UINib(nibName: "LatestResultCollectionViewCell", bundle: nil)
    }

}
