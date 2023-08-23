//
//  CreditsAPI.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import Alamofire
import Foundation

struct CreditsAPI {
    private init() {}

    static func request(
        id: Int,
        completion: @escaping (CastContainer?) -> ()
    ) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(id)/credits"
        components.queryItems = [
            URLQueryItem(
                name: "api_key",
                value: APIKey.credits
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
                of: CastContainer.self
            ) { response in
                completion(response.value)
            }
    }

}
