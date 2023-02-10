//
//  ApiData.swift
//  SportsApp
//
//  Created by Salma on 05/02/2023.
//

import Foundation
import Alamofire
protocol LeagueService
{
  static  func fetchLeagueViewController(url : String, completionHandler : @escaping (Leagues?)->Void)
}

class ApiData : LeagueService
{
    static  func fetchLeagueViewController(url: String, completionHandler: @escaping (Leagues?) -> Void) {
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
