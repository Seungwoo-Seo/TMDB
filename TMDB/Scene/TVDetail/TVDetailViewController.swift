//
//  TVDetailViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import UIKit

final class TVDetailViewController: UIViewController {
    // MARK: - View
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Data
    var tv: TVSeries?
    var tvSeriesDetail: TVSeriesDetail?
    var tvSeason: TVSeason?

    var episodeList: [Episode] = []


    // MARK: - Manager
    let networkingManager = NetworkingManager.shared

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        bind()
    }

    // MARK: - Bind
    func bind() {
        networkingFlow()
    }

    // MARK: - Event

}

extension TVDetailViewController: UITableViewDataSource {

    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        return TVDetailTableViewSectionKind.allCases.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let section = TVDetailTableViewSectionKind.allCases[section]

        switch section {
        case .overview: return 1
        case .content: return episodeList.count
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let section = TVDetailTableViewSectionKind.allCases[indexPath.section]

        switch section {
        case .overview:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TVDetailTableViewOverviewCell.identifier,
                for: indexPath
            ) as? TVDetailTableViewOverviewCell

            cell?.bind(tvSeriesDetail)

            return cell ?? UITableViewCell()

        case .content:
            return UITableViewCell()
        }
    }

}

extension TVDetailViewController: UITableViewDelegate {

}

extension TVDetailViewController: UI_ViewControllerConvention {

    func configureHierarchy() {
        configureTableViews()
    }

    func configureTableViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension


    }

}

extension TVDetailViewController {

    func networkingFlow() {
        guard let tv else {return}
        let group = DispatchGroup()

        group.enter()
        networkingManager.fetchTVSeriesDetail(
            id: tv.id
        ) { [weak self] (tvSeriesDetail) in
            guard let self else {return}
            self.tvSeriesDetail = tvSeriesDetail

            self.networkingManager.fetchTVSeason(
                seriesId: tvSeriesDetail.id,
                seasonNumber: tvSeriesDetail.seasons[0].seasonNumber
            ) { tvSeason in
                self.tvSeason = tvSeason
                self.episodeList = tvSeason.episodes

                group.leave()
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.tableView.reloadData()
        }
    }

}
