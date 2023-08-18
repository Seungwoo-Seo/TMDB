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
    var airingTodayList: [TV] = []
    var onTheAirList: [TV] = []
    var popularList: [TV] = []
    var topRatedList: [TV] = []

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
        networking.responseAllTVSeriesListsAPI { [weak self] dic in
            self?.airingTodayList = dic[TVSeriesKind.airingToday.rawValue] ?? []
            self?.onTheAirList = dic[TVSeriesKind.onTheAir.rawValue] ?? []
            self?.popularList = dic[TVSeriesKind.popular.rawValue] ?? []
            self?.topRatedList = dic[TVSeriesKind.topRated.rawValue] ?? []

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
            let tv = airingTodayList[indexPath.row]
            cell?.bind(tv)
        case .onTheAir:
            let tv = onTheAirList[indexPath.row]
            cell?.bind(tv)
        case .popular:
            let tv = popularList[indexPath.row]
            cell?.bind(tv)
        case .topRated:
            let tv = topRatedList[indexPath.row]
            cell?.bind(tv)
        }

        return cell ?? UICollectionViewCell()
    }

}

// MARK: - UICollectionViewDelegate
extension TVMainViewController: UICollectionViewDelegate {

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

        let nib = UINib(
            nibName: TVMainCollectionViewCell.identifier,
            bundle: nil
        )
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: TVMainCollectionViewCell.identifier
        )
    }

}
