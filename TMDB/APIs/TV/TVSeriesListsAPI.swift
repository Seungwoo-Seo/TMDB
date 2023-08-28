//
//  TVSeriesListsAPI.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import Alamofire
import Foundation

struct TVSeriesListsAPI {
    
    func request(
        endPoint: EndPoint,
        completion: @escaping ([TVSeries]) -> ()
    ) {
        let url = endPoint.url + "api_key=\(APIKey.tmdb)&language=ko-KR"

        AF
            .request(url, method: .get)
            .validate()
            .responseDecodable(of: TVSeriesContainer.self) { response in
                switch response.result {
                case .success(let container):
                    completion(container.tvList)
                case .failure(let error):
                    print("TVSeriesListsAPI 에러")
                    print(error.localizedDescription)
                }
            }
    }

}
