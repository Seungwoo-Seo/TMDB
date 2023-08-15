//
//  Trending.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import Foundation

struct TrendingContainer: Decodable {
    let page: Int
    let results: [Trending]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Trending: Decodable {
    let adult: Bool
    let backdropPath: String
    let title: String
    let overview: String
    let posterPath: String
    let mediaType: MediaType
    let genre: [Int]
    let releaseDate: String
    let rating: Double

    private let baseURL = "https://image.tmdb.org/t/p/original"

    var backdropURL: URL? {
        return URL(string: baseURL + backdropPath)
    }

    var posterURL: URL? {
        return URL(string: baseURL + posterPath)
    }

    var ratingString: String {
        return String(format: "%.1f", rating)
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case title
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genre = "genre_ids"
        case releaseDate = "release_date"
        case rating = "vote_average"
    }
}

enum MediaType: String, Codable {
    case movie
    case tv
    case people
}
