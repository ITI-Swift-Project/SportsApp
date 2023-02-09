//
//  ViewModel.swift
//  SportsApp
//
//  Created by Ahmad Ayman Mansour on 04/02/2023.
//

import Foundation

class ViewModel
{
    
    var bindResultToViewController : ( ()->() ) = {}
    
    var newData : [LeaguesDetails]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    func getLeagues (url : String)
    {
        ApiData.fetchData(url:url ,completionHandler: { result in
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
}


