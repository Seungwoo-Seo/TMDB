//
//  DetailTableViewSectionKind.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import Foundation

enum DetailTableViewSectionKind: Int, CaseIterable {
    case overview
    case cast

    var headerTitle: String {
        switch self {
        case .overview: return "Overview"
        case .cast: return "Cast"
        }
    }
}
