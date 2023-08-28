//
//  TVDetailViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import SnapKit
import UIKit

final class TVDetailViewController: UIViewController {
    // MARK: - View
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableHeaderView = tableHeaderView
        tableView.register(
            TVDetailTableViewOverviewCell.self,
            forCellReuseIdentifier: TVDetailTableViewOverviewCell.identifier
        )
        tableView.register(
            TVDetailTableViewEpisodeCell.self,
            forCellReuseIdentifier: TVDetailTableViewEpisodeCell.identifier
        )
        return tableView
    }()
    private lazy var tableHeaderView = {
        let header = TVDetailTableHeaderView(frame: .zero)
        header.unwindButton.addTarget(
            self,
            action: #selector(didTapUnwindButton),
            for: .touchUpInside
        )

        return header
    }()

    // MARK: - Data
    var tv: TVSeries?
    var tvSeriesDetail: TVSeriesDetail?
    var tvSeasonDetail: TVSeasonDetail?

    // MARK: - Manager
    let networkingManager = NetworkingManager.shared

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initalAttributes()
        initalHierarchy()
        fetchDataForTVDetailScene()
    }

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
        case .episode: return tvSeasonDetail?.episodes.count ?? 0
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

            cell?.bind(tvSeriesDetail: tvSeriesDetail)

            return cell ?? UITableViewCell()

        case .episode:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TVDetailTableViewEpisodeCell.identifier,
                for: indexPath
            ) as? TVDetailTableViewEpisodeCell

            let episode = tvSeasonDetail?.episodes[indexPath.row]
            cell?.bind(episode: episode, posterURL: tvSeriesDetail?.posterURL)

            return cell ?? UITableViewCell()
        }
    }

}

extension TVDetailViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
    }

}

extension TVDetailViewController {

    @objc
    func didTapUnwindButton(_ sender: UIButton) {
        dismiss(animated: true)
    }

}

extension TVDetailViewController {

    func initalAttributes() {
        view.backgroundColor = .black
    }

    func initalHierarchy() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        tableHeaderView.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.width.equalToSuperview()
        }
    }

}

extension TVDetailViewController {

    func fetchDataForTVDetailScene() {
        guard let tv else {return}
        let group = DispatchGroup()

        group.enter()
        networkingManager.fetchTVSeriesDetail(
            id: tv.id
        ) { [weak self] (tvSeriesDetail) in
            guard let self else {return}
            self.tvSeriesDetail = tvSeriesDetail

            self.networkingManager.fetchTVSeasonDetail(
                seriesId: tvSeriesDetail.id,
                seaseonNumber: tvSeriesDetail.seasons[0].seasonNumber
            ) { tvSeasonDetail in
                self.tvSeasonDetail = tvSeasonDetail
                group.leave()
            }
        }

        group.notify(queue: .main) { [weak self] in
            guard let self,
                  let tvSeriesDetail = self.tvSeriesDetail
            else {return}
            self.tableView.reloadData()
            self.tableHeaderView.bind(
                tvSeriesDetail: tvSeriesDetail
            )
            self.tableHeaderView.layoutIfNeeded()
        }
    }

}
