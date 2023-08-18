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

    func responseTrendingAPI(
        page: Int,
        completion: @escaping ([Movie]) -> ()
    ) {
        TrendingAPI.requestMovie(
            page: page,
            success: { container in
                completion(container.movieList)
            },
            failure: { error in
                // TODO: error 처리
            }
        )
    }

    func responseTrendingAPI(
        page: Int,
        completion: @escaping ([TV]) -> ()
    ) {
        TrendingAPI.requestTV(
            page: page,
            success: { container in
                completion(container.tvList)
            },
            failure: { error in
                // TODO: error 처리
            }
        )
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

    func responseTVSeriesListsAPI(
        kind: TVSeriesKind,
        page: Int,
        completion: @escaping ([TV]) -> ()
    ) {
        TVSeriesListsAPI.request(
            kind: kind,
            page: page
        ) { container in
            completion(container.tvList)
        }
    }

    func responseAllTVSeriesListsAPI(
        completion: @escaping ([String : [TV]]) -> ()
    ) {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .background)
        var dic = [
            TVSeriesKind.airingToday.rawValue: [TV](),
            TVSeriesKind.onTheAir.rawValue: [TV](),
            TVSeriesKind.popular.rawValue: [TV](),
            TVSeriesKind.topRated.rawValue: [TV]()
        ]

        for tvSeries in TVSeriesKind.allCases {
            group.enter()
            queue.async(group: group) {
                TVSeriesListsAPI.request(
                    kind: tvSeries,
                    page: 1
                ) { container in
                    dic[tvSeries.rawValue] = container.tvList
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            completion(dic)
        }
    }

}
