//
//  Trending.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import Foundation

// MARK: - MovieContainer
struct MovieContainer: Decodable {
    let movieList: [Movie]

    enum CodingKeys: String, CodingKey {
        case movieList = "results"
    }
}

// MARK: - Movie
struct Movie: Decodable {
    let id: Int
    let backdropPath: String
    let title: String
    let overview: String
    let posterPath: String
    let genreList: [Genre]
    let releaseDate: String
    let rating: Double

    private let imageBaseURL = "https://image.tmdb.org/t/p/original"

    var backdropURL: URL? {
        return URL(string: imageBaseURL + backdropPath)
    }

    var posterURL: URL? {
        return URL(string: imageBaseURL + posterPath)
    }

    var genresStringValue: String {
        var stringValue = ""

        for genre in genreList {
            stringValue += "#\(genre.stringValue)"
        }

        return stringValue
    }

    var ratingStringValue: String {
        return String(format: "%.1f", rating)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case title
        case overview
        case posterPath = "poster_path"
        case genreList = "genre_ids"
        case releaseDate = "release_date"
        case rating = "vote_average"
    }
}

// MARK: - Genre
// api 호출에 제한이 있기 때문에 이런식으로 작성해주면 확실히 도움이 될 듯 하다
enum Genre: Int, Decodable {
    case 액션 = 28
    case 모험 = 12
    case 애니메이션 = 16
    case 코미디 = 35
    case 범죄 = 80
    case 다큐멘터리 = 99
    case 드라마 = 18
    case 가족 = 10751
    case 판타지 = 14
    case 역사 = 36
    case 공포 = 27
    case 음악 = 10402
    case 미스터리 = 9648
    case 로맨스 = 10749
    case SF = 878
    case TV영화 = 10770
    case 스릴러 = 53
    case 전쟁 = 10752
    case 서부 = 7

    var stringValue: String {
        return String(describing: self)
    }
}
