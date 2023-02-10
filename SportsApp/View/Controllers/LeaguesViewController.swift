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
    var tableViewResponse : [LeaguesDetails]?
    
    @IBOutlet weak var LeaguesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewmodel = ViewModel()
        
        viewmodel.getLeagues(url: leagueUrl!)
        
        viewmodel.bindResultToViewController = { () in
            DispatchQueue.main.async {
                self.tableViewResponse = viewmodel.newData
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
        let LeagueDetailsObj = SecondStoryBoardObj.instantiateViewController(withIdentifier: "LeagueDetails")
        LeagueDetailsObj.modalPresentationStyle = .fullScreen
        self.present(LeagueDetailsObj, animated: true ,completion: nil)
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
