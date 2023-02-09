//
//  Teams.swift
//  fetch3requests
//
//  Created by Ahmad Ayman Mansour on 07/02/2023.
//

import Foundation

class Team : Decodable {
    
  var team_key : Int?
  var team_name : String?
  var team_logo : String?
    
}

class TeamsDetailsData : Decodable {
    var result : [Team]?
}
