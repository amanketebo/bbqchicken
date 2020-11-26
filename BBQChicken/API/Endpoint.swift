//
//  Endpoint.swift
//  BBQChicken
//
//  Created by Amanuel Ketebo on 11/20/20.
//

import Foundation

enum Endpoint {
    case playerIndex

    var urlComponents: URLComponents? {
        switch self {
        case .playerIndex:
            var components = URLComponents(string: "https://stats.nba.com/stats/playerindex")

            components?.queryItems = [URLQueryItem(name: "LeagueID", value: "00"),
                                      URLQueryItem(name: "Season", value: "2019-20"),
                                      URLQueryItem(name: "Historical", value: "1"),
                                      URLQueryItem(name: "TeamID", value: "0"),
                                      URLQueryItem(name: "SeasonType", value: "Regular Season")]

            return components
        }
    }

    var httpMethod: String {
        switch self {
        case .playerIndex:
            return "GET"
        }
    }

    var httpHeaderFields: [String: String] {
        return ["Accept": "*/*",
                "Accept-Language": "en-us",
                "Referer": "Referer https://www.nba.com/players"]
    }
}
