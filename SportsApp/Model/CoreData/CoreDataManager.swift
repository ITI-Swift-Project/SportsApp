//
//  CoreData.swift
//  SportsApp
//
//  Created by Ahmad Ayman Mansour on 11/02/2023.
//


import UIKit
import CoreData


class CoreDataManager {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext : NSManagedObjectContext!
    let entity : NSEntityDescription!
    
    private static var dataBaseInstance : CoreDataManager?
    
    public static func getInstance() -> CoreDataManager{
        if let instance = dataBaseInstance {
            return instance
        }else{
            dataBaseInstance = CoreDataManager()
            return dataBaseInstance!
        }
    }
    
    private init (){
        
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "LeaguesCoreData", in: managedContext)
    }
    
    
    func saveToCoreData(favourite : FavouriteLeagueData, sportName: String) {
        let newFavLeague = NSEntityDescription.insertNewObject(forEntityName: "LeaguesCoreData", into: managedContext)
        
        newFavLeague.setValue(favourite.league_key, forKey: "league_key")
        newFavLeague.setValue(favourite.league_name , forKey: "league_name")
        newFavLeague.setValue(favourite.league_logo , forKey: "league_logo")
        newFavLeague.setValue(sportName, forKey: "sportName")

        try?self.managedContext.save()
        
    }
    
    func fetchFormCoreData() -> [NSManagedObject]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeaguesCoreData")
        if let arr = try? managedContext.fetch(fetchRequest) {
            if arr.count > 0 {
                return arr
            }
           return nil
        }else{
            return nil
        }
    }
    

    func deleteFromCoreData (leagueID : Int) {
        if let arr = fetchFormCoreData() {
            for obj in arr {
                if obj.value(forKey:"league_key") as! Int == leagueID{
                    managedContext.delete(obj)
                    try?managedContext.save()
                }
            }
        }
    }


}

