//
//  MockNetworkServicesManagerTestes.swift
//  SportsAppTests
//
//  Created by Ahmad Ayman Mansour on 14/02/2023.
//

import XCTest
import Alamofire
@testable import SportsApp

final class MockNetworkServicesManagerTestes: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchLeagueViewController(){
        MockNetworkServicesManger.fetchLeagueViewController(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=4&from=2023-01-18&to=2024-01-18&APIkey=148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277") { result in
            guard let result = result else {
                XCTFail()
                return
            }
            XCTAssertNotEqual(result.result?.count, 0, "API Failed")
        }
    }
    
    
    func testFetchUpcomingEventsData(){
        MockNetworkServicesManger.fetchUpcomingEventsData(sportName: "football", leagueID: 4) { result in
            guard let result = result else {
                XCTFail()
                return
            }
            XCTAssertNotEqual(result.result?.count, 0, "API Failed")
        }
    }
    
    func testFetchLatestResultsData(){
        MockNetworkServicesManger.fetchLatestResultsData(sportName: "football", leagueID: 4) { result in
            guard let result = result else {
                XCTFail()
                return
            }
            XCTAssertNotEqual(result.result?.count, 0, "API Failed")
        }
        
    }
    func testFetchTeamsData(){
        
        MockNetworkServicesManger.fetchTeamsData(sportName: "football", leagueID: 4) { result in
            guard let result = result else {
                XCTFail()
                return
            }
            XCTAssertNotEqual(result.result?.count, 0, "API Failed")
        }
    }
    
}
