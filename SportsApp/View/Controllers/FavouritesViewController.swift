//
//  FavouritesViewController.swift
//  SportsApp
//
//  Created by Salma on 05/02/2023.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var FavouritesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FavouritesTableView.delegate = self
        FavouritesTableView.dataSource = self
        FavouritesTableView.reloadData()

        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        FavouritesTableView.register(nib, forCellReuseIdentifier: "TableCell")
    }
    
}
extension FavouritesViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let FavouriteTablecell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        FavouriteTablecell.LeaugeLogo.layer.cornerRadius = 37
        
        FavouriteTablecell.LeagueName.layer.cornerRadius = 10
        
        FavouriteTablecell.LeagueName.layer.masksToBounds = true
        return FavouriteTablecell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
