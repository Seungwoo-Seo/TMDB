//
//  TVSeasonDetail.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/25.
//

import Foundation

struct TVSeasonDetail: Decodable {
    let episodes: [Episode]
    let name: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case episodes, name
        case seasonNumber = "season_number"
    }
}

struct Episode: Decodable {
    let episodeNumber: Int
    let name, overview: String
    let runtime: Int?
    let stillPath: String?

    private let imageBaseURL = "https://image.tmdb.org/t/p/original"

    var stillURL: URL? {
        guard let stillPath else {return nil}
        return URL(string: imageBaseURL + stillPath)
    }

    enum CodingKeys: String, CodingKey {
        case episodeNumber = "episode_number"
        case name, overview
        case runtime
        case stillPath = "still_path"
    }
}
