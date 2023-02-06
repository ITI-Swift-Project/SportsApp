//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Salma on 05/02/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    @IBOutlet weak var UpcomingEventsCollectionView: UICollectionView!
    @IBOutlet weak var LatestResultsCollectionView: UICollectionView!
    @IBOutlet weak var TeamsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        UpcomingEventsCollectionView.delegate = self
        UpcomingEventsCollectionView.dataSource = self
        
        UpcomingEventsCollectionView.register(UpcomingEventsCollectionViewCell.nib(), forCellWithReuseIdentifier: "UpcomingEventsCollectionViewCell")
        
        LatestResultsCollectionView.delegate = self
        LatestResultsCollectionView.dataSource = self
        
        LatestResultsCollectionView.register(LatestResultCollectionViewCell.nib(), forCellWithReuseIdentifier: "LatestResultCollectionViewCell")
        
       
        TeamsCollectionView.delegate = self
        TeamsCollectionView.dataSource = self
        
        TeamsCollectionView.register(TeamCollectionViewCell.nib(), forCellWithReuseIdentifier: "TeamCollectionViewCell")
        
    }
    

    
    // MARK: - Navigation



}

extension LeagueDetailsViewController : UICollectionViewDelegate {
    
    
}

extension LeagueDetailsViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.UpcomingEventsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventsCollectionViewCell", for: indexPath) as! UpcomingEventsCollectionViewCell
            
//            cell.upcomingEventAwayTeamImageView.image = UIImage(systemName: "sportscourt.circle.fill")
//            cell.upcomingEventHomeTeamImageView.image = UIImage(systemName: "soccerball")
            
            return cell
            
        } else if collectionView == self.LatestResultsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultCollectionViewCell", for: indexPath) as! LatestResultCollectionViewCell
            
            cell.eventHomeTeamImageView.image = UIImage(systemName: "sportscourt.circle.fill")
            cell.eventAwayTeamImageView.image = UIImage(systemName: "soccerball")
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            cell.teamImageView.image = UIImage(systemName: "soccerball")
            
            return cell
        }
        
    }
    
    
}

extension LeagueDetailsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.UpcomingEventsCollectionView {
            return CGSize(width: 360, height: 112)
        }else if collectionView == self.LatestResultsCollectionView {
            return CGSize(width: 360, height: 112)
        }else{
            return CGSize(width: 112, height: 112)
        }
    }
}
