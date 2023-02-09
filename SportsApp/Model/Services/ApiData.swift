//
//  ApiData.swift
//  SportsApp
//
//  Created by Salma on 05/02/2023.
//

import Foundation
import Alamofire

var APIKey = "148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277"

//MARK: - Protocols For Networking Services

protocol LeagueService
{
  static  func fetchData(url : String, completionHandler : @escaping (Leagues?)->Void)
}

protocol UpcomingData {
    static func fetchUpcomingEventsData (sportName : String , leagueID : Int , complitionHandler: @escaping(UpcomingEventsData?)->Void)
}
protocol LatestEventsData {
    static func fetchLatestResultsData (sportName : String , leagueID : Int ,complitionHandler: @escaping(LatestResultsData?)->Void)
}
protocol TeamsData {
    static func fetchTeamsData (sportName : String , leagueID : Int ,complitionHandler: @escaping(TeamsDetailsData?)->Void)
}

//MARK: - Networking Servesices Work Area

class ApiData : LeagueService
{
    static  func fetchData(url: String, completionHandler: @escaping (Leagues?) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: Leagues.self) { (data) in
            guard let newdata = data.value else{
                completionHandler(nil)
                return
            }
            completionHandler(newdata)
        }
    }
}


//MARK: Fetching Data For LeagueDetailsViewController
class NetworkServices : UpcomingData {
    static func fetchUpcomingEventsData(sportName: String, leagueID: Int, complitionHandler: @escaping (UpcomingEventsData?) -> Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueID)&from=2023-01-18&to=2024-01-18&APIkey=\(APIKey)")
          .validate()
          .responseDecodable(of: UpcomingEventsData.self) { (data) in
            guard let data = data.value else { return }
              complitionHandler(data)
          }
    }
}

extension NetworkServices : LatestEventsData {
    static func fetchLatestResultsData(sportName: String, leagueID: Int, complitionHandler: @escaping (LatestResultsData?) -> Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueID)&from=2022-01-18&to=2023-01-18&APIkey=\(APIKey)")
            .validate()
            .responseDecodable(of:LatestResultsData.self) { (data) in
                guard let data = data.value else { return }
                complitionHandler(data)
             
                
        }
    }
}

extension NetworkServices : TeamsData {
    static func fetchTeamsData(sportName: String, leagueID: Int, complitionHandler: @escaping (TeamsDetailsData?) -> Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Teams&?met=Leagues&leagueId=\(leagueID)&APIkey=\(APIKey)")
          .validate()
          .responseDecodable(of: TeamsDetailsData.self) { (data) in
            guard let data = data.value else { return }
              complitionHandler(data)
          }
    }
}
