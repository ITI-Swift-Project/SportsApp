//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Ahmad Ayman Mansour on 06/02/2023.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    
    var players: [player]?
    var teamName : String?
    var teamLogo : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playersCollectionView.delegate = self
        playersCollectionView.dataSource = self
        
        playersCollectionView.register(PlayerCollectionViewCell.nib(), forCellWithReuseIdentifier: "PlayerCollectionViewCell")
        
        teamImageView.kf.setImage(with: URL(string:teamLogo ?? "" ),placeholder: UIImage(systemName:"slowmo"))
        teamNameLabel.text = teamName
        
        self.collectionViewStyle(on: playersCollectionView)
    }
    
    func collectionViewStyle(on cv:UICollectionView){
        cv.layer.cornerRadius = 12.0
        cv.layer.borderWidth = 3
        cv.layer.borderColor = UIColor.gray.cgColor
        cv.layer.shadowColor = UIColor.black.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cv.layer.shadowRadius = 12
        cv.layer.shadowOpacity = 0.8
        cv.layer.masksToBounds = true

    }

}

//MARK: - Collection View Protocols

extension TeamDetailsViewController : UICollectionViewDelegate {
    
}

extension TeamDetailsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return players?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"PlayerCollectionViewCell", for: indexPath ) as! PlayerCollectionViewCell
        
        cell.playerNameLabel.text = players?[indexPath.row].player_name
        cell.playerPositionLabel.text = "Position : \(players?[indexPath.row].player_type ?? "")"
        cell.playerNumberLabel.text = "Number : \(players?[indexPath.row].player_number ?? "")"
        cell.playerAgeLabel.text = "Age : \(players?[indexPath.row].player_age ?? "")"
        cell.yellowCardsLabel.text = " : \(players?[indexPath.row].player_yellow_cards ?? "")"
        cell.redCardsLabel.text =  " : \(players?[indexPath.row].player_red_cards ?? "")"
        cell.matchesLabel.text = "Matches : \(players?[indexPath.row].player_match_played ?? "")"
        cell.goalsLabel.text = "Goals : \(players?[indexPath.row].player_goals ?? "")"
        cell.layer.cornerRadius = 115/2
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        
        
        cell.playerImagView.kf.setImage(with: URL(string:players?[indexPath.row].player_image ?? "" ),placeholder: UIImage(systemName:"slowmo"))
        
        
        return cell
    }
    
    
}

extension TeamDetailsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width)-20, height: (collectionView.bounds.height/2)-40)
    }
    
}
