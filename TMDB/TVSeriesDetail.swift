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
    let rating: Double

    private let backdropBaseURL = "https://image.tmdb.org/t/p/w1066_and_h600_bestv2"
    private let posterBaseURL = "https://image.tmdb.org/t/p/original"

    var backdropURL: URL? {
        guard let backdropPath else {return nil}
        return URL(string: backdropBaseURL + backdropPath)
    }

    var posterURL: URL? {
        return URL(string: posterBaseURL + posterPath)
    }

    var ratingStringValue: String {
        return String(format: "%.1f", rating)
    }

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
//        case genres
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case seasons
        case rating = "vote_average"
    }
}

struct TVSeason: Decodable {
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case seasonNumber = "season_number"
    }
}
