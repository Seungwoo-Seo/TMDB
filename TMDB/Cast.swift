//
//  Cast.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import Foundation

struct CastContainer: Codable {
    let castList: [Cast]

    enum CodingKeys: String, CodingKey {
        case castList = "cast"
    }
}

struct Cast: Codable {
    let name: String
    let originalName: String
    let profilePath: String?
    let character: String?

    private let baseURL = "https://www.themoviedb.org/t/p/w276_and_h350_face"

    var profireURL: URL? {
        guard let profilePath else {return nil}
        return URL(string: baseURL + profilePath)
    }

    enum CodingKeys: String, CodingKey {
        case name
        case originalName = "original_name"
        case profilePath = "profile_path"
        case character
    }
}
