//
//  TVMainViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/17.
//

import UIKit

final class TVMainViewController: UIViewController {
    // MARK: - View
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Data
    var airingTodayList: [TVSeries] = []
    var onTheAirList: [TVSeries] = []
    var popularList: [TVSeries] = []
    var topRatedList: [TVSeries] = []

    var currentPage = 1

    // MARK: - Manager
    let networking = NetworkingManager.shared

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        bind()
    }

    // MARK: - Bind
    func bind() {
        networking.fetchTVSeries { [weak self] dicList in
            self?.airingTodayList = dicList[.오늘방영] ?? []
            self?.onTheAirList = dicList[.방영중] ?? []
            self?.popularList = dicList[.인기있는] ?? []
            self?.topRatedList = dicList[.높은평점] ?? []

            self?.collectionView.reloadData()
        }
    }

    // MARK: - Event
}

// MARK: - UICollectionViewDataSource
extension TVMainViewController: UICollectionViewDataSource {

    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        return TVMainCollectionViewSectionKind.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let section = TVMainCollectionViewSectionKind.allCases[section]
        switch section {
        case .airingToday: return airingTodayList.count
        case .onTheAir: return onTheAirList.count
        case .popular: return popularList.count
        case .topRated: return topRatedList.count
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = TVMainCollectionViewSectionKind.allCases[indexPath.section]

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TVMainCollectionViewCell.identifier,
            for: indexPath
        ) as? TVMainCollectionViewCell

        switch section {
        case .airingToday:
            let tv = airingTodayList[indexPath.item]
            cell?.bind(tv)
        case .onTheAir:
            let tv = onTheAirList[indexPath.item]
            cell?.bind(tv)
        case .popular:
            let tv = popularList[indexPath.item]
            cell?.bind(tv)
        case .topRated:
            let tv = topRatedList[indexPath.item]
            cell?.bind(
                tv,
                isRanking: true,
                item: indexPath.item + 1
            )
        }

        return cell ?? UICollectionViewCell()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let section = TVMainCollectionViewSectionKind.allCases[indexPath.section]

        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TVMainCollectionReusableViewHeader.identifier,
                for: indexPath
            ) as? TVMainCollectionReusableViewHeader

            header?.bind(section.headerTitle)

            return header ?? UICollectionReusableView()

        } else {
            return UICollectionReusableView()
        }
    }

}

// MARK: - UICollectionViewDelegate
extension TVMainViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let section = TVMainCollectionViewSectionKind.allCases[indexPath.section]

        let tv: TVSeries
        switch section {
        case .airingToday:
            tv = airingTodayList[indexPath.item]
        case .onTheAir:
            tv = onTheAirList[indexPath.item]
        case .popular:
            tv = popularList[indexPath.item]
        case .topRated:
            tv = topRatedList[indexPath.item]
        }

        pushToTVDetailViewController(with: tv)
    }

}

// MARK: - UI: viewDidLoad
extension TVMainViewController: UI_ViewControllerConvention {

    func configureHierarchy() {
        configureCollectionViews()
    }

    func configureCollectionViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = TVMainCollectionViewLayout.compositional.layout

        // Cell
        let cellNib = UINib(
            nibName: TVMainCollectionViewCell.identifier,
            bundle: nil
        )
        collectionView.register(
            cellNib,
            forCellWithReuseIdentifier: TVMainCollectionViewCell.identifier
        )

        // header
        let headerNib = UINib(
            nibName: TVMainCollectionReusableViewHeader.identifier,
            bundle: nil
        )
        collectionView.register(
            headerNib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TVMainCollectionReusableViewHeader.identifier
        )
    }

}

// MARK: - 화면 전환
private extension TVMainViewController {

    func pushToTVDetailViewController(with tv: TVSeries) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: TVDetailViewController.identifier
        ) as! TVDetailViewController

        vc.tv = tv

        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

}
