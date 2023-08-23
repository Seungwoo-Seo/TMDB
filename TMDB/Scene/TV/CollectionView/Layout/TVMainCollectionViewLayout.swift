//
//  TVMainCollectionViewLayout.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import UIKit

enum TVMainCollectionViewLayout {
    case compositional

    var layout: UICollectionViewLayout {
        switch self {
        case .compositional:
            return compositionalLayout()
        }
    }

}

private extension TVMainCollectionViewLayout {

    func compositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            let section = TVMainCollectionViewSectionKind.allCases[sectionIndex]
            switch section {
            case .airingToday: return self.horizontalList()
            case .onTheAir: return self.horizontalList()
            case .popular: return self.horizontalList()
            case .topRated: return self.horizontalList(
                width: 0.45,
                height: 0.4
            )
            }
        }

        return layout
    }

    func horizontalListHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        return header
    }

    func horizontalList(
        width: CGFloat = 0.3,
        height: CGFloat = 0.2
    ) -> NSCollectionLayoutSection {
        let contentInset: CGFloat = 4.0

        // itme
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )

        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .fractionalHeight(height)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 1
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: contentInset,
            bottom: 0,
            trailing: contentInset
        )

        // section
        let section = NSCollectionLayoutSection(
            group: group
        )
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: contentInset,
            bottom: 0,
            trailing: contentInset
        )

        let header = horizontalListHeader()
        section.boundarySupplementaryItems = [
            header
        ]

        return section
    }

}
