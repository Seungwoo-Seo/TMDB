//
//  TVEpisode.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/22.
//

import Foundation

struct Episode: Decodable {
    let airDate: String
    let episodeNumber: Int
    let name, overview: String
    let runtime: Int
    let stillPath: String?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case name, overview
        case runtime
        case stillPath = "still_path"
    }
}
