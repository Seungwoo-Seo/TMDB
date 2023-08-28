//
//  TVMainViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/17.
//

import SnapKit
import UIKit

final class TVMainViewController: UIViewController {
    // MARK: - View
    private lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: TVMainCollectionViewLayout.compositional.layout
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(
            TVMainCollectionViewCell.self,
            forCellWithReuseIdentifier: TVMainCollectionViewCell.identifier
        )
        collectionView.register(
            TVMainCollectionReusableViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TVMainCollectionReusableViewHeader.identifier
        )

        return collectionView
    }()

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

        initalAttributes()
        initalHierarchy()
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

        let vc = TVDetailViewController()
        vc.tv = tv

        transition(
            viewController: vc,
            style: .presentToFullScreen
        )
    }

}

// MARK: - UI
extension TVMainViewController {

    func initalAttributes() {
        view.backgroundColor = .black
    }

    func initalHierarchy() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension TVMainViewController {

    enum TransitionStyle {
        case presentToFullScreen
    }

    func transition<T: UIViewController>(
        viewController: T,
        style: TransitionStyle
    ) {
        switch style {
        case .presentToFullScreen:
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }

}
