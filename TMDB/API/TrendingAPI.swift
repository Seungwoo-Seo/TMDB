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

    static func requestMovie(
        page: Int,
        success: @escaping (MovieContainer) -> (),
        failure: @escaping (Error) -> ()
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
                of: MovieContainer.self
            ) { response in
                switch response.result {
                case .success(let container): success(container)
                case .failure(let error): failure(error)
                }
            }
    }

    static func requestTV(
        page: Int,
        success: @escaping (TVContainer) -> (),
        failure: @escaping (Error) -> ()
    ) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/trending/tv/week"
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
                of: TVContainer.self
            ) { response in
                switch response.result {
                case .success(let container):
                    print("success")
                    success(container)
                case .failure(let error):
                    print("failure")
                    failure(error)
                }
            }
    }

}
