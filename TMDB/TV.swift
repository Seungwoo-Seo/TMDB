//
//  TV.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/18.
//

import Foundation

// MARK: - TVContainer
struct TVContainer: Decodable {
    let page: Int
    let tvList: [TV]

    enum CodingKeys: String, CodingKey {
        case page
        case tvList = "results"
    }
}

// MARK: - TV
struct TV: Decodable {
    let backdropPath: String?
    let id: Int
    let name: String
    let overview: String
    let posterPath: String
    let genreList: [Int]
    let firstAirDate: String
    let rating: Double

    private let imageBaseURL = "https://image.tmdb.org/t/p/original"

    var backdropURL: URL? {
        guard let backdropPath else {return nil}
        return URL(string: imageBaseURL + backdropPath)
    }

    var posterURL: URL? {
        return URL(string: imageBaseURL + posterPath)
    }

    var genresStringValue: String {
        var stringValue = ""

//        for genre in genreList {
//            stringValue += "#\(genre.stringValue)"
//        }

        return stringValue
    }

    var ratingStringValue: String {
        return String(format: "%.1f", rating)
    }

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case genreList = "genre_ids"
        case firstAirDate = "first_air_date"
        case rating = "vote_average"
    }
}
