
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Salma on 05/02/2023.

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
    var sportName : String?
    var leagueID : Int?
    var leagueLogo : String?
    var leagueName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dispatchGroup = DispatchGroup()
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
       
        
        dispatchGroup.enter()
        viewModel?.getUpcomingEventsData(sportName: sportName ?? "football" , leagueID: leagueID ?? 4)
        dispatchGroup.enter()
        viewModel?.getLatestEventsData(sportName: sportName ?? "football" , leagueID: leagueID ?? 4)
        dispatchGroup.enter()
        viewModel?.getTeamsData(sportName: sportName ?? "football" , leagueID: leagueID ?? 4)
        
        viewModel?.bindUpcoimgEventsResultToLeaguesDetailsViewController = { () in
            self.renderUpcomingEventsCollectionView()
            dispatchGroup.leave()
        }
        viewModel?.bindLatestResultsToLeaguesDetailsViewController = { () in
            self.renderLatestEventsCollectionView()
            dispatchGroup.leave()
        }
        viewModel?.bindTeamsDataResultToLeaguesDetailsViewController = { () in
            self.renderTeamsCollectionView()
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main){
            self.UpcomingEventsCollectionView.reloadData()
            self.LatestResultsCollectionView.reloadData()
            self.TeamsCollectionView.reloadData()
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
        }
    }
    
    func renderLatestEventsCollectionView() {
        DispatchQueue.main.async {
            self.latestReultsArray = self.viewModel?.latestEventsResult ?? []
        }
    }
    
    func renderTeamsCollectionView() {
        DispatchQueue.main.async {
            self.teamsArray = self.viewModel?.teamsDataResult ?? []
        }
    }
    
    //MARK: - Core Data Method
   
    func checkFavouriteState(){
        if viewModel.checkFavouriteState(leagueId: leagueID ?? 0) {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.systemYellow
        }else{
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named:"mygrey")
        }
    }
    
    @objc func pressedFavourite() {
        
        if viewModel.favouriteState {
            let alert : UIAlertController = UIAlertController(title: "Delete League", message: "Are you sure you want to delete this league?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default , handler: { [self]action in
                viewModel.deleteFromFavourite(leagueId:leagueID! )
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named:"mygrey")
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true , completion: nil)
        }else{
            viewModel.addToFavourite(leagueData: FavouriteLeagueData(league_key: leagueID!, league_name: leagueName ?? "" , league_logo: leagueLogo ?? "" ), sportName: sportName ?? "")
            navigationItem.rightBarButtonItem?.tintColor =  UIColor.systemYellow
    
        }
        
    }
    
    //MARK: - Navogation Bar Items And Gesture

    func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action:#selector(dismissViewController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named:"mygrey")
        
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
        cv.layer.borderColor = UIColor.gray.cgColor
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
    
    override func viewWillAppear(_ animated: Bool) {
        if let tabItems = tabBarController?.tabBar.items {
            if viewModel?.database.fetchFormCoreData()?.count == 0 {
                let tabItem = tabItems[1]
                tabItem.badgeValue = ""
            }
            let tabItem = tabItems[1]
            let count = viewModel?.database.fetchFormCoreData()?.count ?? 0
            tabItem.badgeValue = String(count)
        }
    }
}


    // MARK: - Collections' Views Protocols
extension LeagueDetailsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == TeamsCollectionView {
            let teamDtailsVC = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
            teamDtailsVC.players = teamsArray?[indexPath.row].players
            teamDtailsVC.teamName = teamsArray?[indexPath.row].team_name
            teamDtailsVC.teamLogo =  teamsArray?[indexPath.row].team_logo
            self.present(teamDtailsVC, animated: true ,completion: nil)
        }
    }
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
            
            if sportName == "basketball" {
                cell.upcomingEventHomeTeamImageView.kf.indicatorType = .activity
                cell.upcomingEventHomeTeamImageView.kf.setImage(with: URL(string: upcomingEventsArray?[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
                cell.upcomingEventAwayTeamImageView.kf.indicatorType = .activity
                cell.upcomingEventAwayTeamImageView.kf.setImage(with: URL(string: upcomingEventsArray?[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
            }else{
                cell.upcomingEventHomeTeamImageView.kf.indicatorType = .activity
                cell.upcomingEventHomeTeamImageView.kf.setImage(with: URL(string: upcomingEventsArray?[indexPath.row].home_team_logo ?? ""),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
                cell.upcomingEventAwayTeamImageView.kf.indicatorType = .activity
                cell.upcomingEventAwayTeamImageView.kf.setImage(with: URL(string: upcomingEventsArray?[indexPath.row].away_team_logo ?? ""),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
            }

            cell.upcomingEventHomeTeamNameLabel.text = upcomingEventsArray?[indexPath.row].event_home_team
            cell.upcomingEventAwayTeamNameLabel.text = upcomingEventsArray?[indexPath.row].event_away_team
            cell.upcomingEventDateLabel.text = upcomingEventsArray?[indexPath.row].event_date
            cell.upcomingEventTimeLabel.text = upcomingEventsArray?[indexPath.row].event_time
            return cell
            
        case LatestResultsCollectionView :
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultCollectionViewCell", for: indexPath) as! LatestResultCollectionViewCell
            
            if sportName == "basketball" {
                cell.eventHomeTeamImageView.kf.indicatorType = .activity
                cell.eventHomeTeamImageView.kf.setImage(with: URL(string:latestReultsArray?[indexPath.row].event_home_team_logo ?? "" ),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
                cell.eventAwayTeamImageView.kf.indicatorType = .activity
                cell.eventAwayTeamImageView.kf.setImage(with: URL(string:latestReultsArray?[indexPath.row].event_away_team_logo ?? "" ),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
            }else{
                
                cell.eventHomeTeamImageView.kf.indicatorType = .activity
                cell.eventHomeTeamImageView.kf.setImage(with: URL(string:latestReultsArray?[indexPath.row].home_team_logo ?? "" ),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
                cell.eventAwayTeamImageView.kf.indicatorType = .activity
                cell.eventAwayTeamImageView.kf.setImage(with: URL(string:latestReultsArray?[indexPath.row].away_team_logo ?? "" ),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
                
            }
            cell.eventHomeTeamNameLabel.text = latestReultsArray?[indexPath.row].event_home_team
            cell.eventAwayTeamNameLabel.text = latestReultsArray?[indexPath.row].event_away_team
            cell.eventFinalResultLabel.text = latestReultsArray?[indexPath.row].event_final_result
            cell.eventDataLabel.text = latestReultsArray?[indexPath.row].event_date
            return cell
            
        case TeamsCollectionView :
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            cell.teamImageView.kf.indicatorType = .activity
            cell.teamImageView.kf.setImage(with: URL(string:teamsArray?[indexPath.row].team_logo ?? "" ),placeholder: UIImage(systemName:"exclamationmark.circle.fill"))
            cell.teamImageView.layer.cornerRadius = cell.teamImageView.bounds.width/2
            cell.teamImageView.layer.borderWidth = 2
            cell.teamImageView.layer.borderColor = UIColor.gray.cgColor
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
            return CGSize(width: (UpcomingEventsCollectionView.bounds.width)-100, height:(UpcomingEventsCollectionView.bounds.height)-10)
        case LatestResultsCollectionView :
            return CGSize(width: 360, height: 112)
        case TeamsCollectionView :
            return CGSize(width: (TeamsCollectionView.bounds.width)/3, height: TeamsCollectionView.bounds.height-15)
        default :
            return CGSize()
        }
    }
}
