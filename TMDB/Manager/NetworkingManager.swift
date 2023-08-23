//
//  NetworkingManager.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import Foundation

/// 여러 API에서 전달 받은 response를 가공해서 View에 가공된 데이터만 전달해줄 객체
final class NetworkingManager {
    static let shared = NetworkingManager()

    // MARK: - APIs
    private let tvSeriesListAPI = TVSeriesListsAPI()
    private let tvSeriesDetailAPI = TVSeriesDetailAPI()
    private let tvSeasonAPI = TVSeasonAPI()

    // MARK: - init
    private init() {}

    // MARK: - TvSeriesListAPI
    func fetchTVSeries(
        completion: @escaping ([EndPoint : [TVSeries]]) -> ()
    ) {
        let group = DispatchGroup()

        var endPointDicList: [EndPoint: [TVSeries]] = [
            .오늘방영: [TVSeries](),
            .방영중: [TVSeries](),
            .인기있는: [TVSeries](),
            .높은평점: [TVSeries]()
        ]

        for endPointDic in endPointDicList {
            group.enter()
            tvSeriesListAPI.request(
                endPoint: endPointDic.key
            ) { tvList in
                endPointDicList[endPointDic.key] = tvList
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(endPointDicList)
        }
    }

    // MARK: - TvSeriesDetailAPI
    // 별도 처리사항 없음 -> 바로 데이터 전달
    func fetchTVSeriesDetail(
        id: Int,
        completion: @escaping (TVSeriesDetail) -> ()
    ) {
        tvSeriesDetailAPI.request(
            endPoint: .시리즈(seriesId: id)
        ) { tvSeriesDetail in
            completion(tvSeriesDetail)
        }
    }

    // MARK: - TVSeasonAPI
    // 별도 처리사항 없음 -> 바로 데이터 전달
    func fetchTVSeason(
        seriesId: Int,
        seasonNumber: Int,
        completion: @escaping (TVSeason) -> ()
    ) {
        tvSeasonAPI.request(
            endPoint: .시즌(
                seriesId: seriesId,
                seasonNumber: seasonNumber
            )
        ) { tvSeason in
            completion(tvSeason)
        }
    }

}

extension NetworkingManager {

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
        completion: @escaping ([TVSeries]) -> ()
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

}
