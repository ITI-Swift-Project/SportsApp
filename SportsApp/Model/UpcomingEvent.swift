//
//  UpcomingEvent.swift
//  fetch3requests
//
//  Created by Ahmad Ayman Mansour on 07/02/2023.
//

import Foundation

class UpcomingEvent :Decodable {
    
    var  event_date : String?
    var  event_time : String?
    var  event_home_team : String?
    var  event_away_team : String?
    var  home_team_logo : String?
    var  away_team_logo : String?
    
}

class UpcomingEventsData : Decodable {
    var result : [UpcomingEvent]?
}
