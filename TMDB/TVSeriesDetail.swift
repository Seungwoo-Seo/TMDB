//
//  TVSeriesDetail.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/20.
//

import Foundation

// MARK: - TVSeriesDetail
struct TVSeriesDetail: Decodable {
    let backdropPath: String?
    let firstAirDate: String
//    let genres: [Int]
    let id: Int
    let name: String
    let overview: String
    let posterPath: String
    let seasons: [TVSeason]
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
//        case genres
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case seasons
        case voteAverage = "vote_average"
    }
}
