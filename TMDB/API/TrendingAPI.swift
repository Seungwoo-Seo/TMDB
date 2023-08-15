//
//  TrendingAPI.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import Alamofire
import Foundation

struct TrendingAPI {
    private init() {}

    static func request(
        page: Int,
        completion: @escaping (TrendingContainer?) -> ()
    ) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/trending/movie/week"
        components.queryItems = [
            URLQueryItem(
                name: "api_key",
                value: APIKey.trending
            ),
            URLQueryItem(
                name: "page",
                value: "\(page)"
            ),
            URLQueryItem(
                name: "language",
                value: "ko-KR"
            )
        ]

        guard let url = components.url else {return}

        AF
            .request(
                url,
                method: .get
            )
            .validate()
            .responseDecodable(
                of: TrendingContainer.self
            ) { response in
                completion(response.value)
            }
    }

}

//enum API {
//    case trending
//
//    func request(
//        completion: @escaping (TrendingContainer?) -> ()
//    ) {}
//}


