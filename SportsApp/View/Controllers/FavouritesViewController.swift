//
//  FavouritesViewController.swift
//  SportsApp
//
//  Created by Salma on 05/02/2023.
//

import UIKit
import CoreData
import Kingfisher
import Reachability

class FavouritesViewController: UIViewController {
    
    var FavouriteViewModel : ViewModel?
    var FavouriteLeagues : [NSManagedObject]?
    var Footballarray : [NSManagedObject] = []
    var Basketballarray : [NSManagedObject] = []
    var Cricketarray : [NSManagedObject] = []
    var Tennisarray : [NSManagedObject] = []


    @IBOutlet weak var FavouritesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FavouriteViewModel = ViewModel()
        FavouriteLeagues = FavouriteViewModel?.database.fetchFormCoreData()
        Filtration()
        
        FavouritesTableView.delegate = self
        FavouritesTableView.dataSource = self

        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        FavouritesTableView.register(nib, forCellReuseIdentifier: "TableCell")
    }

    
    override func viewWillAppear(_ animated: Bool) {
       FavouriteLeagues = FavouriteViewModel?.database.fetchFormCoreData()
       Filtration()
       self.FavouritesTableView.reloadData()
    }
    
    
    func Filtration()
    {
        if !((FavouriteLeagues ?? []).isEmpty){
            Footballarray = []
            Basketballarray = []
            Cricketarray = []
            Tennisarray = []
            for league in FavouriteLeagues ?? []
            {
                if ((league.value(forKey: "sportName") ?? "") as! String == "football")
                {
                    Footballarray.append(league)
                }
                else if ((league.value(forKey: "sportName") ?? "") as! String == "basketball")
                {
                    Basketballarray.append(league)
                }
                else if ((league.value(forKey: "sportName") ?? "") as! String == "cricket")
                {
                    Cricketarray.append(league)
                }
                else if ((league.value(forKey: "sportName") ?? "") as! String == "tennis")
                {
                    Tennisarray.append(league)
                }
                    
            }
        }else{
            Footballarray = []
            Basketballarray = []
            Cricketarray = []
            Tennisarray = []
        }
    }

}

extension FavouritesViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SecondStoryBoardObj = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
        let reachability = Reachability.forInternetConnection()
        
        if reachability?.isReachable() == true
        {
            let LeagueDetailsObj = SecondStoryBoardObj.instantiateViewController(withIdentifier: "LeagueDetails") as! LeagueDetailsViewController
            switch (indexPath.section)
            {
                case 0:
                LeagueDetailsObj.leagueID = Footballarray[indexPath.row].value(forKey: "league_key") as? Int
                LeagueDetailsObj.sportName = Footballarray[indexPath.row].value(forKey: "sportName") as? String
            case 1:
                LeagueDetailsObj.leagueID = Basketballarray[indexPath.row].value(forKey: "league_key") as? Int
                LeagueDetailsObj.sportName = Basketballarray[indexPath.row].value(forKey: "sportName") as? String
            case 2:
                LeagueDetailsObj.leagueID = Cricketarray[indexPath.row].value(forKey: "league_key") as? Int
                LeagueDetailsObj.sportName = Cricketarray[indexPath.row].value(forKey: "sportName") as? String
            case 3:
                LeagueDetailsObj.leagueID = Tennisarray[indexPath.row].value(forKey: "league_key") as? Int
                LeagueDetailsObj.sportName = Tennisarray[indexPath.row].value(forKey: "sportName") as? String
                
            default:
                break
            }
            
            let navController = UINavigationController(rootViewController: LeagueDetailsObj)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true ,completion: nil)
            
        }
        else
        {
            let alert : UIAlertController = UIAlertController(title: "Connection Issue!", message: "No Internet Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
      if let headerView = view as? UITableViewHeaderFooterView {
          headerView.contentView.backgroundColor = UIColor(named: "mygrey")
          headerView.textLabel?.textColor = UIColor(named:"mycolor")
      }
  }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

extension FavouritesViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section)
        {
        case 0:
            return Footballarray.count
        case 1:
            return Basketballarray.count
        case 2:
            return Cricketarray.count
        case 3:
            return Tennisarray.count
        
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let FavouriteTablecell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        switch(indexPath.section)
        {
        case 0:
            FavouriteTablecell.LeagueName.text = (Footballarray[indexPath.row].value(forKey: "league_name") as? String)
            FavouriteTablecell.LeaugeLogo.kf.setImage(with: URL(string: Footballarray[indexPath.row].value(forKey: "league_logo") as! String),placeholder: UIImage(named: "loading"))
        case 1 :
            FavouriteTablecell.LeagueName.text = (Basketballarray[indexPath.row].value(forKey: "league_name") as? String)
            FavouriteTablecell.LeaugeLogo.kf.setImage(with: URL(string: Basketballarray[indexPath.row].value(forKey: "league_logo") as? String ?? ""),placeholder: UIImage(named: "loading"))
        case 2:
            FavouriteTablecell.LeagueName.text = (Cricketarray[indexPath.row].value(forKey: "league_name") as? String)
            FavouriteTablecell.LeaugeLogo.kf.setImage(with: URL(string: Cricketarray[indexPath.row].value(forKey: "league_logo") as? String ?? ""),placeholder: UIImage(named: "loading"))
        case 3:
            FavouriteTablecell.LeagueName.text = (Tennisarray[indexPath.row].value(forKey: "league_name") as? String)
            FavouriteTablecell.LeaugeLogo.kf.setImage(with: URL(string: Tennisarray[indexPath.row].value(forKey: "league_logo") as? String ?? ""),placeholder: UIImage(named: "loading"))
        default:
            break
            
        }
        FavouriteTablecell.LeaugeLogo.layer.cornerRadius = 37

        return FavouriteTablecell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert : UIAlertController = UIAlertController(title: "Delete League", message: "Are you sure you want to delete this league?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default , handler: { [self]action in
            FavouriteViewModel?.deleteFromFavourite(leagueId: (FavouriteLeagues?[indexPath.row].value(forKey: "league_key")as? Int ?? 0))
            FavouriteLeagues = FavouriteViewModel?.database.fetchFormCoreData()
            Filtration()
            FavouritesTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true , completion: nil)
     
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section)
        {
        case 0:
            return "Football"
        case 1:
            return "Basketball"
        case 2:
            return "Cricket"
        case 3:
            return "Tennis"
        default:
            return ""
        }
    }
}
