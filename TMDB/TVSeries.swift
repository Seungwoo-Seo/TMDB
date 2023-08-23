//
//  TVSeries.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/18.
//

import Foundation

// MARK: - TVSeriesContainer
struct TVSeriesContainer: Decodable {
    let page: Int
    let tvList: [TVSeries]

    enum CodingKeys: String, CodingKey {
        case page
        case tvList = "results"
    }
}

// MARK: - TVSeries
struct TVSeries: Decodable, Hashable {
    let id: Int
    let posterPath: String?
    let rating: Double

    private let imageBaseURL = "https://image.tmdb.org/t/p/original"

    var posterURL: URL? {
        guard let posterPath else {return nil}
        return URL(string: imageBaseURL + posterPath)
    }

    var ratingStringValue: String {
        return String(format: "%.1f", rating)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case rating = "vote_average"
    }
}
