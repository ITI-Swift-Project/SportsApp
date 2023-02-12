//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Salma on 04/02/2023.
//

import UIKit
import Kingfisher

class LeaguesViewController: UIViewController {
    
    var leagueUrl : String?
    var sporName : String?
    var tableViewResponse : [LeaguesDetails]?
    var LeaugeViewModel : ViewModel?
    
    @IBOutlet weak var LeaguesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LeaugeViewModel = ViewModel()
        
        LeaugeViewModel?.getLeagues(url: leagueUrl!)
        
        LeaugeViewModel?.bindResultToViewController = { () in
            DispatchQueue.main.async { [self] in
                self.tableViewResponse = LeaugeViewModel?.newData
                self.LeaguesTableView.reloadData()
            }
           
        }
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        LeaguesTableView.register(nib, forCellReuseIdentifier: "TableCell")
        
        LeaguesTableView.delegate = self
        LeaguesTableView.dataSource = self
    
    }
}


extension LeaguesViewController : UITableViewDelegate
{
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SecondStoryBoardObj = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
        let LeagueDetailsObj = SecondStoryBoardObj.instantiateViewController(withIdentifier: "LeagueDetails") as! LeagueDetailsViewController
       
        LeagueDetailsObj.leagueID = tableViewResponse?[indexPath.row].league_key
        LeagueDetailsObj.sportName = self.sporName
        LeagueDetailsObj.leagueName = tableViewResponse?[indexPath.row].league_name ?? ""
        LeagueDetailsObj.leagueData?.league_logo = tableViewResponse?[indexPath.row].league_logo ?? ""
        LeagueDetailsObj.leagueData?.league_name =  tableViewResponse?[indexPath.row].league_name ?? ""
        LeagueDetailsObj.leagueData?.league_key = tableViewResponse![indexPath.row].league_key ?? 0
        let navController = UINavigationController(rootViewController: LeagueDetailsObj)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true ,completion: nil)

      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}


extension LeaguesViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewResponse?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let LeaguesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        
        LeaguesTableViewCell.LeagueName.text = tableViewResponse![indexPath.row].league_name
        
        LeaguesTableViewCell.LeaugeLogo.kf.setImage(with: URL(string: tableViewResponse![indexPath.row].league_logo ?? ""),placeholder: UIImage(named: "loading"))
        
        LeaguesTableViewCell.LeaugeLogo.layer.cornerRadius = 37
        LeaguesTableViewCell.LeaugeLogo.layer.borderWidth = 5
        LeaguesTableViewCell.LeaugeLogo.layer.borderColor = UIColor(named: "mycolor")?.cgColor
        LeaguesTableViewCell.LeagueName.layer.cornerRadius = 10
        LeaguesTableViewCell.LeagueName.layer.masksToBounds = true
        return LeaguesTableViewCell
    }
}
