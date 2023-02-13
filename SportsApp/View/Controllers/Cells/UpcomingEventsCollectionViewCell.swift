//
//  UpcomingEventsCollectionViewCell.swift
//  SportsApp
//
//  Created by Ahmad Ayman Mansour on 06/02/2023.
//

import UIKit

class UpcomingEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var upcomingEventTimeLabel: UILabel!
    @IBOutlet weak var upcomingEventDateLabel: UILabel!
    @IBOutlet weak var upcomingEventAwayTeamImageView: UIImageView!
    @IBOutlet weak var upcomingEventHomeTeamImageView: UIImageView!
    @IBOutlet weak var upcomingEventHomeTeamNameLabel: UILabel!
    @IBOutlet weak var upcomingEventAwayTeamNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib{
    return UINib(nibName: "UpcomingEventsCollectionViewCell", bundle: nil)
    }
    
}
