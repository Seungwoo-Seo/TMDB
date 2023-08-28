//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import Kingfisher
import SnapKit
import UIKit

final class MovieDetailViewController: UIViewController {
    // MARK: - View
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 32
        tableView.sectionFooterHeight = 32
        tableView.register(
            DetailTableViewOverviewCell.self,
            forCellReuseIdentifier: DetailTableViewOverviewCell.identifier
        )
        tableView.register(
            DetailTableViewCastCell.self,
            forCellReuseIdentifier: DetailTableViewCastCell.identifier
        )
        tableView.tableHeaderView = tableHeaderView

        return tableView
    }()
    private lazy var tableHeaderView = {
        let view = MovieDetailTableViewHeader(frame: .zero)
        return view
    }()

    // MARK: - Data
    private var castList: [Cast] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var trending: Movie?

    // MARK: - Manager
    private let shared = NetworkingManager.shared

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initalAttributes()
        initalHierarchy()
        bind()
    }

    // MARK: Bind
    func bind() {
        guard let trending else {return}
        shared.castAPIResponse(
            id: trending.id
        ) { [weak self] (results) in
            self?.castList += results
        }

        tableHeaderView.backdropImageView.kf.setImage(
            with: trending.backdropURL
        )
        tableHeaderView.titleLabel.text = trending.title
        tableHeaderView.posterImageView.kf.setImage(
            with: trending.posterURL
        )
    }

}

// MARK: - UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {

    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        return DetailTableViewSectionKind.allCases.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let section = DetailTableViewSectionKind.allCases[section]
        switch section {
        case .overview: return 1
        case .cast: return castList.count
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let section = DetailTableViewSectionKind.allCases[indexPath.section]

        switch section {
        case .overview:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DetailTableViewOverviewCell.identifier,
                for: indexPath
            ) as? DetailTableViewOverviewCell

            cell?.delegate = self

            if let trending {
                cell?.bind(trending)
            }

            return cell ?? UITableViewCell()

        case .cast:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DetailTableViewCastCell.identifier,
                for: indexPath
            ) as? DetailTableViewCastCell

            let cast = castList[indexPath.row]
            cell?.bind(cast)

            return cell ??  UITableViewCell()
        }
    }

    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        let section = DetailTableViewSectionKind.allCases[section]
        return section.headerTitle
    }

}

// MARK: - DetailTableViewOverviewCellDelegate
extension MovieDetailViewController: DetailTableViewOverviewCellDelegate {

    func didTapExpandButton(
        _ sender: UIButton,
        overviewLabel: UILabel
    ) {
        if sender.isSelected {
            sender.isSelected = false
            overviewLabel.numberOfLines = 2
        } else {
            sender.isSelected = true
            overviewLabel.numberOfLines = 0
        }

        tableView.reloadData()
    }

}

// MARK: - UI
extension MovieDetailViewController {

    func initalAttributes() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = "출연/제작"
        view.backgroundColor = .black
    }

    func initalHierarchy() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        tableHeaderView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
    }

}
