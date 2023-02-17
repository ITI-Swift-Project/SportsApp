import Foundation

class player : Decodable {
    
  var  player_key :Int?
  var  player_name :String?
  var  player_number :String?
  var  player_country :String?
  var  player_type : String?
  var  player_age : String?
  var  player_match_played : String?
  var  player_goals :String?
  var  player_yellow_cards : String?
  var  player_red_cards : String?
  var  player_image : String?
    
}

class coach : Decodable {
    var coach_name : String?
    var coach_country : String?
    var coach_age  : String?
}





class Team : Decodable {
    
  var team_key : Int?
  var team_name : String?
  var team_logo : String?
  var players :[player]?
  var coaches : [coach]?
    
}


class TeamsDetailsData : Decodable {
    var result : [Team]?
}

