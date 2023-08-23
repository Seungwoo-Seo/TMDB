//
//  TVSeason.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/22.
//

import Foundation

struct TVSeason: Decodable {
    let episodes: [Episode]
    let name: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case episodes, name
        case seasonNumber = "season_number"
    }
}
