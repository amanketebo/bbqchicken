//
//  PlayerIndexResponse.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/20/20.
//

import Foundation

struct PlayerIndexResponse: Decodable {
    // MARK: Types

    struct Paramaters: Decodable {
        let leagueID: String?
        let season: String?
        let historical: Int?
        let teamID: Int?
    }

    struct ResultSet: Decodable {
        let name: String?
        let headers: [String]?
        let rowSet: [RowSetInfo]
    }

    struct RowSetInfo: Decodable {
        let playerID: Int
        let firstName: String?
        let lastName: String?
        let playerSlug: String?
        let teamID: Int?
        let teamSlug: String?
        let isDefunct: Int?
        let teamCity: String?
        let teamName: String?
        let teamAbbreviation: String?
        let jerseyNumber: String?
        let position: String?
        let height: String?
        let weight: String?
        let college: String?
        let country: String?
        let draftYear: Int?
        let draftRound: Int?
        let draftNumber: Int?
        let rosterStatus: String?
        let pointsPerGame: Float?
        let reboundsPerGame: Float?
        let assistsPerGame: Float?

        // MARK: - Init
        
        init(from decoder: Decoder) throws {
            var container = try? decoder.unkeyedContainer()
            playerID = (try? container?.decode(Int.self)) ?? -1
            lastName = try? container?.decodeIfPresent(String.self)
            firstName = try? container?.decodeIfPresent(String.self)
            playerSlug = try? container?.decodeIfPresent(String.self)
            teamID = try? container?.decodeIfPresent(Int.self)
            teamSlug = try? container?.decodeIfPresent(String.self)
            isDefunct = try? container?.decodeIfPresent(Int.self)
            teamCity = try? container?.decodeIfPresent(String.self)
            teamName = try? container?.decodeIfPresent(String.self)
            teamAbbreviation = try? container?.decodeIfPresent(String.self)
            jerseyNumber = try? container?.decodeIfPresent(String.self)
            position = try? container?.decodeIfPresent(String.self)
            height = try? container?.decodeIfPresent(String.self)
            weight = try? container?.decodeIfPresent(String.self)
            college = try? container?.decodeIfPresent(String.self)
            country = try? container?.decodeIfPresent(String.self)
            draftYear = try? container?.decodeIfPresent(Int.self)
            draftRound = try? container?.decodeIfPresent(Int.self)
            draftNumber = try? container?.decodeIfPresent(Int.self)
            rosterStatus = try? container?.decodeIfPresent(String.self)
            pointsPerGame = try container?.decodeIfPresent(Float.self)
            reboundsPerGame = try container?.decodeIfPresent(Float.self)
            assistsPerGame = try container?.decodeIfPresent(Float.self)
        }
    }

    // MARK: - Properties

    let resource: String
    let parameters: Paramaters?
    let resultSets: [ResultSet]?
}
