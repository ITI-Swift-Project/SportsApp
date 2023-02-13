//
//  LatestResults.swift
//  fetch3requests
//
//  Created by Ahmad Ayman Mansour on 07/02/2023.
//

import Foundation

class LatestResult : Decodable {
    
    var  event_date : String?
    var  event_time : String?
    var  event_home_team :String?
    var  event_away_team : String?
    var  away_team_key : Int?
    var  home_team_key : Int?
    var  event_final_result : String?
    var  home_team_logo : String?
    var  away_team_logo: String?
    
    //Tennis
    var  event_first_player : String?
    var  event_second_player : String?
    var  first_player_key :  Int?
    var  second_player_key : Int?
    var event_first_player_logo : String?
    var event_second_player_logo : String?
    
}

class LatestResultsData : Decodable {
    var result : [LatestResult]?
}
