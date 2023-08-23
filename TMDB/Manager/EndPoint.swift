//
//  EndPoint.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/20.
//

import Foundation

enum EndPoint: Hashable {
    case 오늘방영
    case 방영중
    case 인기있는
    case 높은평점
    case 시리즈(seriesId: Int)
    case 시즌(seriesId: Int, seasonNumber: Int)
    case 에피소드(seriesId: Int, seasonNumber: Int, episodeNumber: Int)

    var identifier: String {
        return String(describing: self)
    }

    var fullPath: String {
        let endPoint: String

        switch self {
        case .오늘방영:
            endPoint = "airing_today"
        case .방영중:
            endPoint = "on_the_air"
        case .인기있는:
            endPoint = "popular"
        case .높은평점:
            endPoint = "top_rated"

        case .시리즈(let seriesId):
            endPoint = "\(seriesId)"

        case let .시즌(seriesId, seasonNumber):
            endPoint = "\(seriesId)/season/\(seasonNumber)"
        case let .에피소드(seriesId, seasonNumber, episodeNumber):
            endPoint = "\(seriesId)/season/\(seasonNumber)/episode/\(episodeNumber)"
        }

        return baseURL + endPoint + "?"
    }

    private var baseURL: String {
        return "https://api.themoviedb.org/3/tv/"
    }
}
