//
//  TVSeasonDetailAPI.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/22.
//

import Alamofire
import Foundation

struct TVSeasonDetailAPI {

    func request(
        endPoint: EndPoint,
        completion: @escaping (TVSeasonDetail) -> ()
    ) {
        let url = endPoint.url

        AF
            .request(url, method: .get)
            .validate()
            .responseDecodable(of: TVSeasonDetail.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print("TVSeasonDetailAPI 에러")
                    print(error.localizedDescription)
                }
            }
    }

}
