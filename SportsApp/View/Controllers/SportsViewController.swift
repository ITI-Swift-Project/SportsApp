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
    var urlsports : [String] = ["football","basketball","cricket","tennis"]
    var ApiKey : String = "148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277"
   
    @IBOutlet weak var SportsViewCollection: UICollectionView!
    
    @IBOutlet weak var CollectionViewBackground: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        SportsViewCollection.register(nib, forCellWithReuseIdentifier: "SportsCell")
        
       SportsViewCollection.delegate = self
       SportsViewCollection.dataSource = self
        
        self.navigationItem.title = "Sports"

        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(named: "mycolor")
    
        
        arrayofimages.append(UIImage(named: "Football")!)
        arrayofimages.append(UIImage(named: "Basketball")!)
        arrayofimages.append(UIImage(named: "Cricket")!)
        arrayofimages.append(UIImage(named: "Tennis")!)
        
        
        sportnames.append("Football")
        sportnames.append("Basketball")
        sportnames.append("Cricket")
        sportnames.append("Tennis")
        
        CollectionViewBackground.image = UIImage(named: "Sports")
    }
}


extension SportsViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let LeaguesViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "League") as! LeaguesViewController
        LeaguesViewControllerObj.leagueUrl = "https://apiv2.allsportsapi.com/\(urlsports[indexPath.row])/?met=Leagues&APIkey=\(ApiKey)"
        self.navigationController?.pushViewController(LeaguesViewControllerObj, animated: true)
    }
}


extension SportsViewController : UICollectionViewDataSource
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
        SportsCollectionViewCell.layer.cornerRadius = 76
        SportsCollectionViewCell.layer.shadowColor = UIColor(named: "mycolor")?.cgColor
        SportsCollectionViewCell.layer.shadowOffset = CGSize(width: 0, height: 0)
        SportsCollectionViewCell.layer.shadowRadius = 5
        SportsCollectionViewCell.layer.shadowOpacity = 1
        SportsCollectionViewCell.layer.masksToBounds = false
        
        return SportsCollectionViewCell
        
    }
}


extension SportsViewController :  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
     {
         return CGSize(width: (UIScreen.main.bounds.size.width/2)-35 , height: (UIScreen.main.bounds.height/5))
     }
}

