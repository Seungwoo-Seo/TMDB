//
//  TVSeriesListsAPI.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import Alamofire
import Foundation

enum TVSeriesKind: String, CaseIterable {
    case airingToday
    case onTheAir
    case popular
    case topRated

    var urlString: String {
        switch self {
        case .airingToday: return "airing_today"
        case .onTheAir: return "on_the_air"
        case .popular: return "popular"
        case .topRated: return "top_rated"
        }
    }
}

struct TVSeriesListsAPI {
    private init() {}

    private static let baseURL = "https://api.themoviedb.org/3/tv"

    static func request(
        kind: TVSeriesKind,
        page: Int,
        success: @escaping (TVContainer) -> ()
    ) {
        let url = "\(baseURL)/\(kind.urlString)?api_key=\(APIKey.tvSeriesLists)&language=ko-KR&page=\(page)"

        AF
            .request(
                url,
                method: .get
            )
            .validate()
            .responseDecodable(
                of: TVContainer.self
            ) { response in
                switch response.result {
                case .success(let container):
                    success(container)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
