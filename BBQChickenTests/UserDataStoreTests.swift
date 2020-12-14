//
//  UserDataStore.swift
//  BBQChickenTests
//
//  Created by Amanuel Ketebo on 12/14/20.
//

import XCTest
@testable import BBQChicken

final class UserDataStoreTests: XCTestCase {

    private var testUserDefaults: UserDefaults!

    override func setUp() {
        testUserDefaults = UserDefaults(suiteName: #file)
        testUserDefaults?.removeSuite(named: #file)
    }

    func testSelectedPlayersLimit_givenSelectedPlayersLimitOfTwo_andThreePlayersStored_twoItemsReturnedInCorrectOrder() {
        let userDataStore = UserDataStore(recentSelectedPlayersLimit: 2, userDefaults: testUserDefaults)

        userDataStore.storeLastSelectedPlayer(MockPlayers.kobeBryant)
        userDataStore.storeLastSelectedPlayer(MockPlayers.jamesHarden)
        userDataStore.storeLastSelectedPlayer(MockPlayers.calvinCambridge)

        XCTAssertEqual(userDataStore.selectedPlayers, [MockPlayers.calvinCambridge, MockPlayers.jamesHarden])
    }
}
