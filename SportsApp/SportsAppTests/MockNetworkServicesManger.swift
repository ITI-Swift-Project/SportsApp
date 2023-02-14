//
//  MockNetworkServicesManger.swift
//  SportsAppTests
//
//  Created by Ahmad Ayman Mansour on 14/02/2023.
//

import Foundation
import Alamofire
@testable import SportsApp

class MockNetworkServicesManger {
    static let mockUpcomingEventsJSONRespond: String = "{\"results\":[{\"event_date\":\"2023-02-23\"},{\"event_date\":\"2023-02-24\"}]}"
    static let mockLatestEventsJSONRespond: String = "{\"results\":[{\"event_date\":\"2023-02-23\"},{\"event_date\":\"2023-02-24\"}]}"
    static let mockTeamsDetailsJSONRespond: String = "{\"results\":[{\"team_name\":\"BayernMunich\"},{\"team_logo\":\"https://apiv2.allsportsapi.com/logo/72_bayern-munich.jpg\"}]}"
}


extension MockNetworkServicesManger : LeagueService , UpcomingData , LatestEventsData , TeamsData {
    static func fetchLeagueViewController(url: String, completionHandler: @escaping (SportsApp.Leagues?) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Leagues.self) { (data) in
            guard let newdata = data.value else{
                completionHandler(nil)
                return
            }
            completionHandler(newdata)
        }
    }
    
    static func fetchUpcomingEventsData(sportName: String, leagueID: Int, complitionHandler: @escaping (SportsApp.UpcomingEventsData?) -> Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueID)&from=2023-01-18&to=2024-01-18&APIkey=\(APIKey)")
          .validate()
          .responseDecodable(of: UpcomingEventsData.self) { (data) in
            guard let data = data.value else { return }
              complitionHandler(data)
          }
    }
    
    static func fetchLatestResultsData(sportName: String, leagueID: Int, complitionHandler: @escaping (SportsApp.LatestResultsData?) -> Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueID)&from=2022-01-18&to=2023-01-18&APIkey=\(APIKey)")
            .validate()
            .responseDecodable(of:LatestResultsData.self) { (data) in
                guard let data = data.value else { return }
                complitionHandler(data)
        }
    }
    
    static func fetchTeamsData(sportName: String, leagueID: Int, complitionHandler: @escaping (SportsApp.TeamsDetailsData?) -> Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Teams&?met=Leagues&leagueId=\(leagueID)&APIkey=\(APIKey)")
          .validate()
          .responseDecodable(of: TeamsDetailsData.self) { (data) in
            guard let data = data.value else { return }
              complitionHandler(data)
          }
    }
}



