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

    @IBOutlet weak var FavouritesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FavouriteViewModel = ViewModel()
        FavouriteLeagues = FavouriteViewModel?.database.fetchFormCoreData()
        
        
        FavouritesTableView.delegate = self
        FavouritesTableView.dataSource = self

        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        FavouritesTableView.register(nib, forCellReuseIdentifier: "TableCell")
       // self.FavouritesTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.FavouritesTableView.reloadData()

    }
}
extension FavouritesViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavouriteLeagues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let FavouriteTablecell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        
        FavouriteTablecell.LeagueName.text = (FavouriteLeagues?[indexPath.row].value(forKey: "league_name") as? String)
        
        FavouriteTablecell.LeaugeLogo.kf.setImage(with: URL(string: FavouriteLeagues![indexPath.row].value(forKey: "league_logo") as! String),placeholder: UIImage(named: "loading"))
        
        FavouriteTablecell.LeaugeLogo.layer.cornerRadius = 37

        return FavouriteTablecell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SecondStoryBoardObj = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
        let reachability = Reachability.forInternetConnection()
        
        if reachability?.isReachable() == true
        {
            let LeagueDetailsObj = SecondStoryBoardObj.instantiateViewController(withIdentifier: "LeagueDetails") as! LeagueDetailsViewController
            self.navigationController?.pushViewController(LeagueDetailsObj, animated: true)
        }
        else
        {
            var alert : UIAlertController = UIAlertController(title: "Internet Issue!", message: "No Internet Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

