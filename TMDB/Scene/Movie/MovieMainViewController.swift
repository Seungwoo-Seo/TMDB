//
//  MovieMainViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import SnapKit
import UIKit

final class MovieMainViewController: UIViewController {
    // MARK: - View
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.triangle"),
            style: .plain,
            target: self,
            action: #selector(didTapLeftBarButtonItem)
        )
        barButtonItem.tintColor = .white

        return barButtonItem
    }()

    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(didTapLeftBarButtonItem)
        )
        barButtonItem.tintColor = .white

        return barButtonItem
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: MainTableViewCell.identifier
        )

        return tableView
    }()

    // MARK: - Data
    private var movieList: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var currentPage = 1

    // MARK: - Manager
    private let networkManager = NetworkingManager.shared

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initalAttributes()
        initalHierarchy()
        bind()
    }

    // MARK: - Bind
    func bind() {
        networkManager.responseTrendingAPI(
            page: currentPage
        ) { [weak self] (movieList) in
            self?.movieList = movieList
        }
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

        let movie = movieList[indexPath.row]
        cell?.bind(to: movie)

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
                networkManager.responseTrendingAPI(
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
        let vc = MovieDetailViewController()

        let treding = movieList[tag]
        vc.trending = treding

        transition(
            viewController: vc,
            style: .push
        )
    }

}

// MARK: - UI
extension MovieMainViewController {
    /// 초기에 추가적인 SubViews 속성 설정
    func initalAttributes() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem

        view.backgroundColor = .black
    }

    /// View를 추가하고 초기 레이아웃을 설정
    func initalHierarchy() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

// MARK: - Event
extension MovieMainViewController {

    @objc
    func didTapLeftBarButtonItem(
        _ sender: UIBarButtonItem
    ) {
    }

    @objc
    func didTapRightBarButtonItem(
        _ sender: UIBarButtonItem
    ) {
    }

}
