//
//  SimpleCardGamesTests.swift
//  SimpleCardGamesTests
//
//  Created by Amarjit on 09/12/2025.
//

@testable import SimpleCardGames
import XCTest

final class SimpleCardGamesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAudioSettingsPersistsToDevice() throws {
        let source = AudioSettings(musicEnabled: false, soundEnabled: true, volume: 0.35)
        let store = AudioSettingsStore(fileName: "test-audio-settings")

        try store.save(source)
        let loaded = try store.load()

        XCTAssertFalse(loaded.musicEnabled)
        XCTAssertTrue(loaded.soundEnabled)
        XCTAssertEqual(loaded.volume, 0.35, accuracy: 0.0001)
    }

}
