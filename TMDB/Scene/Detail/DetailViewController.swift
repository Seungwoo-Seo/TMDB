//
//  DetailViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import Kingfisher
import UIKit

final class DetailViewController: UIViewController {
    // MARK: - View
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    // MARK: - Data
    private var castList: [Cast] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var trending: Trending?

    // MARK: - Manager
    private let shared = NetworkingManager.shared

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
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

        backdropImageView.kf.setImage(
            with: trending.backdropURL
        )
        titleLabel.text = trending.title
        posterImageView.kf.setImage(
            with: trending.posterURL
        )
    }

    // MARK: Event
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {

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
extension DetailViewController: DetailTableViewOverviewCellDelegate {

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

// MARK: - UI: viewDidLoad
extension DetailViewController: UI_ViewControllerConvention {

    func configureHierarchy() {
        configureNavigationBar()
        configureTableViews()
        configureImageViews()
        configureLabels()
    }

    func configureNavigationBar() {
        navigationItem.title = "출연/제작"
    }

    func configureTableViews() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 32
        tableView.sectionFooterHeight = 32
        tableHeaderView.frame = .init(x: 0, y: 0, width: tableView.bounds.width, height: 200)

        let overViewCellNib = UINib(
            nibName: DetailTableViewOverviewCell.identifier,
            bundle: nil
        )
        tableView.register(
            overViewCellNib,
            forCellReuseIdentifier: DetailTableViewOverviewCell.identifier
        )

        let castCellNib = UINib(
            nibName: DetailTableViewCastCell.identifier,
            bundle: nil
        )
        tableView.register(
            castCellNib,
            forCellReuseIdentifier: DetailTableViewCastCell.identifier
        )
    }

    func configureImageViews() {
        // backdropImageView
        backdropImageView.contentMode = .scaleToFill

        // posterImageView
        posterImageView.contentMode = .scaleToFill
    }

    func configureLabels() {
        // titleLabel
        titleLabel.font = .systemFont(ofSize: 24, weight: .black)
        titleLabel.textColor = .white
    }

}
