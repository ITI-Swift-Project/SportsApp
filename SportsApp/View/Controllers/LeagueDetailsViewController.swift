//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Salma on 05/02/2023.
//

import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController {
    
    @IBOutlet weak var UpcomingEventsCollectionView: UICollectionView!
    @IBOutlet weak var LatestResultsCollectionView: UICollectionView!
    @IBOutlet weak var TeamsCollectionView: UICollectionView!
    
    var viewModel : ViewModel!
    var upcomingEventsArray : [UpcomingEvent]?
    var latestReultsArray : [LatestResult]?
    var teamsArray : [Team]?
    var leagueData : FavouriteLeagueData!
    var sportName : String?
    var leagueID : Int?
    var leagueName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("sport : \(sportName ?? "football") , \(leagueID ?? 4 ) \n")
        
        UpcomingEventsCollectionView.delegate = self
        UpcomingEventsCollectionView.dataSource = self
        
        UpcomingEventsCollectionView.register(UpcomingEventsCollectionViewCell.nib(), forCellWithReuseIdentifier: "UpcomingEventsCollectionViewCell")
        
        LatestResultsCollectionView.delegate = self
        LatestResultsCollectionView.dataSource = self
        
        LatestResultsCollectionView.register(LatestResultCollectionViewCell.nib(), forCellWithReuseIdentifier: "LatestResultCollectionViewCell")
        
        
        TeamsCollectionView.delegate = self
        TeamsCollectionView.dataSource = self
        
        TeamsCollectionView.register(TeamCollectionViewCell.nib(), forCellWithReuseIdentifier: "TeamCollectionViewCell")
        
        viewModel = ViewModel()
        
        viewModel?.getUpcomingEventsData(sportName: sportName ?? "football" , leagueID: leagueID ?? 4)
        viewModel?.getLatestEventsData(sportName: sportName ?? "football" , leagueID: leagueID ?? 4)
        viewModel?.getTeamsData(sportName: sportName ?? "football" , leagueID: leagueID ?? 4)
        viewModel?.bindUpcoimgEventsResultToLeaguesDetailsViewController = { () in
            self.renderUpcomingEventsCollectionView()
        }
        viewModel?.bindLatestResultsToLeaguesDetailsViewController = { () in
            self.renderLatestEventsCollectionView()
        }
        viewModel?.bindTeamsDataResultToLeaguesDetailsViewController = { () in
            self.renderTeamsCollectionView()
        }
        
        self.setNavigationItem()
        self.checkFavouriteState()
        self.swipeToDismiss()
        self.collectionViewStyle(on: UpcomingEventsCollectionView)
        self.collectionViewStyle(on: LatestResultsCollectionView)
        self.collectionViewStyle(on: TeamsCollectionView)
        
    }
    
    
    
    
    // MARK: - Rendring View For Collections' Views
    func renderUpcomingEventsCollectionView() {
        DispatchQueue.main.async {
            self.upcomingEventsArray = self.viewModel?.upcomingEventsResult ?? []
            self.UpcomingEventsCollectionView.reloadData()
        }
    }
    
    func renderLatestEventsCollectionView() {
        DispatchQueue.main.async {
            self.latestReultsArray = self.viewModel?.latestEventsResult ?? []
            self.LatestResultsCollectionView.reloadData()
        }
    }
    
    func renderTeamsCollectionView() {
        DispatchQueue.main.async {
            self.teamsArray = self.viewModel?.teamsDataResult ?? []
            self.TeamsCollectionView.reloadData()
        }
    }
    
    //MARK: - Core Data Method
   
    func checkFavouriteState(){
        if viewModel.checkFavouriteState(leagueId: leagueID ?? 0) {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.systemYellow
        }else{
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        }
    }
    
    @objc func pressedFavourite() {
        if viewModel.favouriteState {
            viewModel.deleteFromFavourite(leagueId:leagueID! )
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        }else{
            viewModel.addToFavourite(leagueData: FavouriteLeagueData(league_key: leagueID!, league_name: sportName! , league_logo: "") )
            navigationItem.rightBarButtonItem?.tintColor =  UIColor.systemYellow
            
        }
        
    }
    
    //MARK: - Navogation Bar Items And Gesture

    func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action:#selector(dismissViewController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"star.fill"), style: .plain, target: self, action: #selector(pressedFavourite))
        navigationItem.title = leagueName
    }
    
    func swipeToDismiss() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissViewController))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Methods For Collections Views UI
    func collectionViewStyle(on cv:UICollectionView){
        cv.layer.cornerRadius = 12.0
        cv.layer.borderWidth = 3
        cv.layer.borderColor = UIColor.white.cgColor
        cv.layer.shadowColor = UIColor.black.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cv.layer.shadowRadius = 12
        cv.layer.shadowOpacity = 0.8
        if cv == TeamsCollectionView {
            cv.layer.masksToBounds = false
        }else{
            cv.layer.masksToBounds = true
        }
    }
}


    // MARK: - Collections' Views Protocols
extension LeagueDetailsViewController : UICollectionViewDelegate {
    
    
}

extension LeagueDetailsViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            
        case UpcomingEventsCollectionView :
            return upcomingEventsArray?.count ?? 0
        case LatestResultsCollectionView :
            return latestReultsArray?.count ?? 0
        case TeamsCollectionView :
            return teamsArray?.count ?? 0
        default :
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case UpcomingEventsCollectionView :
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventsCollectionViewCell", for: indexPath) as! UpcomingEventsCollectionViewCell
            
            cell.upcomingEventHomeTeamImageView.kf.setImage(with: URL(string: upcomingEventsArray?[indexPath.row].home_team_logo ?? ""),placeholder: UIImage(systemName:"slowmo"))
            cell.upcomingEventAwayTeamImageView.kf.setImage(with: URL(string: upcomingEventsArray?[indexPath.row].away_team_logo ?? ""),placeholder: UIImage(systemName:"slowmo"))
            
            cell.upcomingEventHomeTeamNameLabel.text = upcomingEventsArray?[indexPath.row].event_home_team
            cell.upcomingEventAwayTeamNameLabel.text = upcomingEventsArray?[indexPath.row].event_away_team
            cell.upcomingEventDateLabel.text = upcomingEventsArray?[indexPath.row].event_date
            cell.upcomingEventTimeLabel.text = upcomingEventsArray?[indexPath.row].event_time
            return cell
            
        case LatestResultsCollectionView :
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultCollectionViewCell", for: indexPath) as! LatestResultCollectionViewCell
            cell.eventHomeTeamImageView.kf.setImage(with: URL(string:latestReultsArray?[indexPath.row].home_team_logo ?? "" ),placeholder: UIImage(systemName:"slowmo"))
            cell.eventAwayTeamImageView.kf.setImage(with: URL(string:latestReultsArray?[indexPath.row].away_team_logo ?? "" ),placeholder: UIImage(systemName:"slowmo"))
            cell.eventHomeTeamNameLabel.text = latestReultsArray?[indexPath.row].event_home_team
            cell.eventAwayTeamNameLabel.text = latestReultsArray?[indexPath.row].event_away_team
            cell.eventFinalResultLabel.text = latestReultsArray?[indexPath.row].event_final_result
            return cell
            
        case TeamsCollectionView :
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            cell.teamImageView.kf.setImage(with: URL(string:teamsArray?[indexPath.row].team_logo ?? "" ),placeholder: UIImage(systemName:"slowmo"))
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension LeagueDetailsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case UpcomingEventsCollectionView :
            return CGSize(width: 360, height: 112)
        case LatestResultsCollectionView :
            return CGSize(width: 360, height: 112)
        case TeamsCollectionView :
            return CGSize(width: 112, height: 112)
        default :
            return CGSize()
        }
    }
}
