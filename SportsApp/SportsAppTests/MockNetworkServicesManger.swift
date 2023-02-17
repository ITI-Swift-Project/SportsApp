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
    static let mockLeaguesJsonRespond : String = "{\"results\":[{\"league_name\":\"name\"},{\"league_logo\":\"logo\"}]}"
    static let mockUpcomingEventsJSONRespond: String = "{\"results\":[{\"event_date\":\"2023-02-23\"},{\"event_date\":\"2023-02-24\"}]}"
    static let mockLatestEventsJSONRespond: String = "{\"results\":[{\"event_date\":\"2023-02-23\"},{\"event_date\":\"2023-02-24\"}]}"
    static let mockTeamsDetailsJSONRespond: String = "{\"results\":[{\"team_name\":\"BayernMunich\"},{\"team_logo\":\"https://apiv2.allsportsapi.com/logo/72_bayern-munich.jpg\"}]}"
}

 //test Alamofire
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
        let data = Data(MockNetworkServicesManger.mockUpcomingEventsJSONRespond.utf8)
        do {
            let response = try JSONDecoder().decode(UpcomingEventsData.self, from: data)
            complitionHandler(response)
        } catch {
            complitionHandler(nil)
        }
    }
    
    static func fetchLatestResultsData(sportName: String, leagueID: Int, complitionHandler: @escaping (SportsApp.LatestResultsData?) -> Void) {
        let data = Data(MockNetworkServicesManger.mockLatestEventsJSONRespond.utf8)
        do {
            let response = try JSONDecoder().decode(LatestResultsData.self, from: data)
            complitionHandler(response)
        } catch {
            complitionHandler(nil)
        }
    }
    
    static func fetchTeamsData(sportName: String, leagueID: Int, complitionHandler: @escaping (SportsApp.TeamsDetailsData?) -> Void) {
        let data = Data(MockNetworkServicesManger.mockTeamsDetailsJSONRespond.utf8)
        do {
            let response = try JSONDecoder().decode(TeamsDetailsData.self, from: data)
            complitionHandler(response)
        } catch {
            complitionHandler(nil)
        }
    }
    
}




