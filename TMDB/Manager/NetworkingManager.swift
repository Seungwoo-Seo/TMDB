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

    // 이름 후보?//?///??/?
    // 1. response
    // 2. parse
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
            guard let container else {
                print("실패")
                return}
            completion(container.castList)
        }
    }

}
