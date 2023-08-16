//
//  NetworkingManager.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()

    private init() {}

    func trendingAPIResponse(
        page: Int,
        completion: @escaping ([Trending]) -> ()
    ) {
        TrendingAPI.request(
            page: page
        ) { container in
            guard let container else {return}
            completion(container.trendingList)
        }
    }

    func castAPIResponse(
        id: Int,
        completion: @escaping ([Cast]) -> ()
    ) {
        CreditsAPI.request(
            id: id
        ) { container in
            guard let container else {return}
            completion(container.castList)
        }
    }

}
