//
//  ProfileViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/29.
//

import SnapKit
import UIKit

final class ProfileViewController: UIViewController {

    private lazy var tableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.tableHeaderView = profileTableViewHeader
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(
            ProfileTableViewCell.self,
            forCellReuseIdentifier: ProfileTableViewCell.identifier
        )

        return tableView
    }()

    private let profileTableViewHeader = {
        let header = ProfileTableViewHeader(frame: .zero)
        return header
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        initalAttirbutes()
        initalHierarhcy()
        tableView.layoutIfNeeded()
    }

}

extension ProfileViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return ProfileTableViewCellKind.allCases.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.identifier,
            for: indexPath
        ) as? ProfileTableViewCell

        let kind = ProfileTableViewCellKind.allCases[indexPath.row]
        cell?.bind(to: kind)

        return cell ?? UITableViewCell()
    }

}

extension ProfileViewController: UITableViewDelegate {

}

private extension ProfileViewController {

    func initalAttirbutes() {
        view.backgroundColor = .black
    }

    func initalHierarhcy() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        profileTableViewHeader.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }

}
