//
//  ViewModel.swift
//  SportsApp
//
//  Created by Ahmad Ayman Mansour on 04/02/2023.
//

import Foundation

class ViewModel {
    
    var bindResultToViewController : ( ()->() ) = {}
    
    var newData : [LeaguesDetails]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    func getLeagues (url : String)
    {
        ApiData.fetchLeagueViewController(url:url ,completionHandler: { result in
            self.newData = result?.result
        })
        
    }
//MARK: - Fetching Data to LeagueDetailsViewController
    
    var bindUpcoimgEventsResultToLeaguesDetailsViewController : (()->()) = {}
    var bindLatestResultsToLeaguesDetailsViewController : (()->()) = {}
    var bindTeamsDataResultToLeaguesDetailsViewController : (()->()) = {}
    
    
    var upcomingEventsResult : [UpcomingEvent]! {
        didSet {
            bindUpcoimgEventsResultToLeaguesDetailsViewController()
        }
    }
    
    var latestEventsResult : [LatestResult]! {
        didSet {
            bindLatestResultsToLeaguesDetailsViewController()
        }
    }
    
    var teamsDataResult : [Team]! {
        didSet {
            bindTeamsDataResultToLeaguesDetailsViewController()
        }
    }
    
  
    func getUpcomingEventsData(sportName:String , leagueID : Int ) {
        NetworkServices.fetchUpcomingEventsData(sportName: sportName, leagueID: leagueID) { result in
            self.upcomingEventsResult = result?.result
        }
    }
    
    func getLatestEventsData(sportName:String , leagueID : Int) {
        NetworkServices.fetchLatestResultsData (sportName: sportName, leagueID: leagueID) { result in
            self.latestEventsResult = result?.result
        }
    }
    
    func getTeamsData(sportName:String , leagueID : Int) {
        NetworkServices.fetchTeamsData (sportName: sportName, leagueID: leagueID) { result in
            self.teamsDataResult = result?.result
        }
    }
    
    //MARK: - View Model For CoreData


        var database = CoreDataManager.getInstance()
        
        var bindingFavouriteState : (()->()) = {}
        
        var favouriteState:Bool!{
            didSet{
                self.bindingFavouriteState()
            }
        }
        
        func checkFavouriteState(leagueId:Int) -> Bool  {
            if let validState = database.fetchFormCoreData() {
                for item in validState{
                    if item.value(forKey: "league_key") as! Int == leagueId {
                        favouriteState = true
                        return true
                    }
                }
                favouriteState = false
                return false
            }else{
                favouriteState = false
                return false
            }
        }
        
        func deleteFromFavourite(leagueId:Int){
            database.deleteFromCoreData(leagueID: leagueId)
            favouriteState = false
        }
        
    func addToFavourite(leagueData : FavouriteLeagueData, sportName : String)  {
        
        database.saveToCoreData(favourite: FavouriteLeagueData(league_key: leagueData.league_key, league_name: leagueData.league_name, league_logo: leagueData.league_logo), sportName: sportName)
            favouriteState = true
        }
}



   
