//
//  MainViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - View
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Data
    private var trendingList: [Trending] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var currentPage = 1

    // MARK: - Manager
    private let shared = NetworkingManager.shared

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        bind()
    }

    // MARK: - Bind
    func bind() {
        shared.trendingAPIResponse(
            page: currentPage
        ){ [weak self] (results) in
            self?.trendingList = results
        }
    }

    // MARK: - Event
    @IBAction func didTapLeftBarButtonItem(
        _ sender: UIBarButtonItem
    ) {
    }

    @IBAction func didTapRightBarButtonItem(
        _ sender: UIBarButtonItem
    ) {
    }

}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return trendingList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.identifier,
            for: indexPath
        ) as? MainTableViewCell

        let trending = trendingList[indexPath.row]
        cell?.bind(trending)

        return cell ?? UITableViewCell()
    }

}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

    }
}

// MARK: - UITableViewDataSourcePrefetching
extension MainViewController: UITableViewDataSourcePrefetching {

    func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths: [IndexPath]
    ) {
        for indexPath in indexPaths {
            if indexPath.row == trendingList.count - 1 && currentPage < 500 {
                currentPage += 1
                shared.trendingAPIResponse(
                    page: currentPage
                ) { [weak self] (results) in
                    self?.trendingList += results
                }
            }
        }
    }

}

// MARK: - UI: viewDidLoad
extension MainViewController: UI_ViewControllerConvention {

    func configureHierarchy() {
        configureNavigationBar()
        configureTableViews()
    }

    func configureNavigationBar() {
        // leftBarButtonItem
        leftBarButtonItem.title = ""
        leftBarButtonItem.image = UIImage(
            systemName: "list.triangle"
        )

        // rightBarButtonItem
        rightBarButtonItem.title = ""
        rightBarButtonItem.image = UIImage(
            systemName: "magnifyingglass"
        )
    }

    func configureTableViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        let nib = UINib(
            nibName: MainTableViewCell.identifier,
            bundle: nil
        )
        tableView.register(
            nib,
            forCellReuseIdentifier: MainTableViewCell.identifier
        )
    }

}

