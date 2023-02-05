//
//  ViewModel.swift
//  SportsApp
//
//  Created by Ahmad Ayman Mansour on 04/02/2023.
//

import Foundation
class ViewModel
{
    
    var bindResultToViewController : ( ()->() ) = {}
    
    var newData : [LeaguesDetails]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    func getLeagues (url : String)
    {
        ApiData.fetchData(url:url ,completionHandler: { result in
            self.newData = result?.result
        })
    }
    }

