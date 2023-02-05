//
//  SportsViewController.swift
//  SportsApp
//
//  Created by Salma on 04/02/2023.
//

import UIKit

class SportsViewController: UIViewController {
    
    var arrayofimages : [UIImage] = []
    var sportnames : [String] = []
    var url = ["https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277" , "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277" , "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277" , "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277" , "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277" , "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277"]

    @IBOutlet weak var SportsViewCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
      /*  let nib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        SportsViewCollection.register(nib, forCellWithReuseIdentifier: "SportsCollectionViewCell")*/
        
       SportsViewCollection.delegate = self
       SportsViewCollection.dataSource = self
        
        self.navigationItem.title = "Sports"

        navigationController?.navigationBar.prefersLargeTitles = true
        
        arrayofimages.append(UIImage(named: "Football")!)
        arrayofimages.append(UIImage(named: "Basketball")!)
        arrayofimages.append(UIImage(named: "Cricket")!)
        arrayofimages.append(UIImage(named: "Hockey")!)
        arrayofimages.append(UIImage(named: "Baseball")!)
        arrayofimages.append(UIImage(named: "Americanfootball")!)
        
        sportnames.append("Football")
        sportnames.append("Basketball")
        sportnames.append("Cricket")
        sportnames.append("Hockey")
        sportnames.append("Baseball")
        sportnames.append("American Football")
    }
}


extension SportsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayofimages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let SportsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCollectionViewCell
        
        SportsCollectionViewCell.SportImage.image = arrayofimages[indexPath.row]
        SportsCollectionViewCell.SportName.text = sportnames[indexPath.row]
        SportsCollectionViewCell.SportName.layer.cornerRadius = 7
        SportsCollectionViewCell.SportName.layer.masksToBounds = true
        SportsCollectionViewCell.layer.cornerRadius = 15
        SportsCollectionViewCell.layer.borderWidth = 5
        SportsCollectionViewCell.layer.borderColor = UIColor.gray.cgColor
        
        return SportsCollectionViewCell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (UIScreen.main.bounds.size.width/2)-35 , height: (UIScreen.main.bounds.height/5))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let LeaguesViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "League") as! LeaguesViewController
        LeaguesViewControllerObj.leagueUrl = url[indexPath.row]
        self.navigationController?.pushViewController(LeaguesViewControllerObj, animated: true)
    }
}
