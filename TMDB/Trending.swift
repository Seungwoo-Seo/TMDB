//
//  Trending.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import Foundation

struct TrendingContainer: Decodable {
    let trendingList: [Trending]

    enum CodingKeys: String, CodingKey {
        case trendingList = "results"
    }
}

struct Trending: Decodable {
    let id: Int
    let backdropPath: String
    let title: String
    let overview: String
    let posterPath: String
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

//    var genreString: String {
//        var resultString = ""
//        genre.forEach {
//            resultString += "#\($0.rawValue)"
//        }
//        return resultString
//    }

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case title
        case overview
        case posterPath = "poster_path"
        case genre = "genre_ids"
        case releaseDate = "release_date"
        case rating = "vote_average"
    }
}

//enum Genre: Int, Codable {
//    case 액션
//    case 모험
//    case 애니메이션
//    case 코미디
//    case 범죄
//    case 다큐멘터리
//    case 드라마
//    case 가족
//    case 판타지
//    case 역사
//    case 공포
//    case 음악
//    case 미스터리
//    case 로맨스
//    case SF
//    case TV영화
//    case 스릴러
//    case 전쟁
//    case 서부
//
//    enum CodingKeys: Int, CodingKey {
//        case 액션 = 28
//        case 모험 = 12
//        case 애니메이션 = 16
//        case 코미디 = 35
//        case 범죄 = 80
//        case 다큐멘터리 = 99
//        case 드라마 = 18
//        case 가족 = 10751
//        case 판타지 = 14
//        case 역사 = 36
//        case 공포 = 27
//        case 음악 = 10402
//        case 미스터리 = 9648
//        case 로맨스 = 10749
//        case SF = 878
//        case TV영화 = 10770
//        case 스릴러 = 53
//        case 전쟁 = 10752
//        case 서부 = 37
//    }
//}

//// MARK: - Welcome
//struct Welcome: Codable {
//    let genres: [Genre]
//}
//
//// MARK: - Genre
//struct Genre: Codable {
//    let id: Int
//    let name: String
//}
