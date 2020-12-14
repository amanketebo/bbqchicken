//
//  VersusViewModelTests.swift
//  BBQChickenTests
//
//  Created by Amanuel Ketebo on 12/14/20.
//

import XCTest
@testable import BBQChicken

final class VersusViewModelTests: XCTestCase {

    // MARK: - Properties

    private var testUserDefaults: UserDefaults!

    // MARK: - Set Up

    override func setUp() {
        testUserDefaults = UserDefaults(suiteName: #file)
        testUserDefaults.removeSuite(named: #file)
        super.setUp()
    }

    func testVersusViewModelStoring_givenStateIsSavedWithTwoPlayers_fetchStateReturnsCorrectArray() {
        let testUserDataStore = UserDataStore(userDefaults: testUserDefaults)
        let mockPlayers = [MockPlayers.kobeBryant, MockPlayers.jamesHarden]
        let versusViewModel = VersusViewModel(initialPlayers: mockPlayers, userDataStore: testUserDataStore)

        versusViewModel.players = mockPlayers
        versusViewModel.saveState()
        // Empty players so we can check when it's populated again.
        versusViewModel.players = []
        versusViewModel.fetchState()

        XCTAssertEqual(versusViewModel.players, mockPlayers)
    }

    func testVersusViewModelStoring_givenStateIsSavedWithOnePlayerAndAnotherNilPlayer_fetchStateReturnsCorrectArray() {
        let testUserDataStore = UserDataStore(userDefaults: testUserDefaults)
        let mockPlayers = [MockPlayers.kobeBryant, nil]
        let versusViewModel = VersusViewModel(initialPlayers: mockPlayers, userDataStore: testUserDataStore)

        versusViewModel.players = mockPlayers
        versusViewModel.saveState()
        // Empty players so we can check when it's populated again.
        versusViewModel.players = []
        versusViewModel.fetchState()

        XCTAssertEqual(versusViewModel.players, mockPlayers)
    }
}
