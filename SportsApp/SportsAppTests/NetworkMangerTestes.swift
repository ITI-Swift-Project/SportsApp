//
//  NetworkMangerTestes.swift
//  SportsAppTests
//
//  Created by Ahmad Ayman Mansour on 14/02/2023.
//

import XCTest
@testable import SportsApp

final class NetworkMangerTestes: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchLeagueViewController(){
        let expectaion = expectation(description: "Waiting for the API to get Leagues List")
        ApiData.fetchLeagueViewController(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=4&from=2023-01-18&to=2024-01-18&APIkey=148568032f35468a98a5d4df064b2c9a049f7e11aa967c780acd4cc415155277") { leagues in
            guard let result = leagues else {
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(result.result?.count, 0, "API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3 , handler: nil)
    }
    
    func testFetchUpcomingEventsData(){
        let expectaion = expectation(description: "Waiting for the API to get Upcoming Events")
        NetworkServices.fetchUpcomingEventsData(sportName: "football", leagueID:4) { result in
            guard let result = result else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(result.result?.count, 0, "API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3 , handler: nil)
        
    }
    func testFetchLatestResultsData(){
        let expectaion = expectation(description: "Waiting for the API to get Latest Events")
        NetworkServices.fetchLatestResultsData(sportName: "football", leagueID:4) { result in
            guard let result = result else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(result.result?.count, 0, "API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3 , handler: nil)
    }
    
    func testFetchTeamsData() {
        let expectaion = expectation(description: "Waiting for the API to get ")
        NetworkServices.fetchTeamsData(sportName: "football", leagueID:4) { result in
            guard let result = result else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertNotEqual(result.result?.count, 0, "API Failed")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 3 , handler: nil)
    }
}
    
    
