//
//  TVSeasonAPI.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/22.
//

import Alamofire
import Foundation

struct TVSeasonAPI {

    func request(
        endPoint: EndPoint,
        completion: @escaping (TVSeason) -> ()
    ) {
        let url = endPoint.fullPath + "api_key=\(APIKey.tmdb)&language=ko-KR"

        AF
            .request(url, method: .get)
            .validate()
            .responseDecodable(of: TVSeason.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

}
