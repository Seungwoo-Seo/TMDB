//
//  TVMainCollectionViewSectionKind.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import UIKit

enum TVMainCollectionViewSectionKind: Int, CaseIterable {
    case airingToday
    case onTheAir
    case popular
    case topRated

    var headerTitle: String {
        switch self {
        case .airingToday: return "오늘 방영"
        case .onTheAir: return "현재 방영중"
        case .popular: return "요즘 핫한 TV 시리즈"
        case .topRated: return "TV 시리즈 순위"
        }
    }
}

extension TVMainCollectionViewSectionKind {

    func test() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(0.2)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(16.0)

        // Section
        let section = NSCollectionLayoutSection(group: group)

        return section
    }


}
