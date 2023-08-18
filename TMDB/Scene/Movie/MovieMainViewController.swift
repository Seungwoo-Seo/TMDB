//
//  MovieMainViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import UIKit

final class MovieMainViewController: UIViewController {
    // MARK: - View
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Data
    private var movieList: [Movie] = [] {
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
        shared.responseTrendingAPI(
            page: currentPage
        ) { [weak self] (movieList) in
            self?.movieList = movieList
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
extension MovieMainViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return movieList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.identifier,
            for: indexPath
        ) as? MainTableViewCell

        cell?.pushButtontag = indexPath.row
        cell?.delegate = self

        let trending = movieList[indexPath.row]
        cell?.bind(trending)

        return cell ?? UITableViewCell()
    }

}

// MARK: - UITableViewDataSourcePrefetching
extension MovieMainViewController: UITableViewDataSourcePrefetching {

    func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths: [IndexPath]
    ) {
        for indexPath in indexPaths {
            if indexPath.row == movieList.count - 1 && currentPage < 500 {
                currentPage += 1
                shared.responseTrendingAPI(
                    page: currentPage
                ) { [weak self] (movieList) in
                    self?.movieList += movieList
                }
            }
        }
    }

}

// MARK: - MainTableViewCellDelegate
extension MovieMainViewController: MainTableViewCellDelegate {
    
    func didTapPushButton(_ tag: Int) {
        pushToDetailViewController(with: tag)
    }

}

// MARK: - UI: viewDidLoad
extension MovieMainViewController: UI_ViewControllerConvention {

    func configureHierarchy() {
        configureNavigationBar()
        configureTableViews()
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""

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

// MARK: - 화면 전환
private extension MovieMainViewController {

    func pushToDetailViewController(with tag: Int) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: MovieDetailViewController.identifier
        ) as! MovieDetailViewController

        let treding = movieList[tag]
        vc.trending = treding

        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

}
