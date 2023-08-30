//
//  ProfileViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/29.
//

import SnapKit
import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - View
    private lazy var leftBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(didTapLeftBarButtomItem)
        )
        return barButtonItem
    }()
    private lazy var rightBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButtomItem)
        )
        barButtonItem.tintColor = .systemBlue
        return barButtonItem
    }()
    lazy var tableView = {
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

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let kind = ProfileTableViewCellKind.allCases[indexPath.row]

        if kind == .프로페셔널_계정으로_전환 || kind == .개인정보_설정 {
            presentAlert()
            return
        }

        let vc = ProfileEditViewController()
        vc.bind(to: kind)
        vc.completion = { result in
            let cell = self.tableView.cellForRow(
                at: indexPath
            ) as? ProfileTableViewCell

            cell?.valueLabel.textColor = .white
            cell?.valueLabel.text = result
        }
        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

}

private extension ProfileViewController {

    func initalAttirbutes() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = "프로필 편집"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backButtonTitle = ""
    }

    func initalHierarhcy() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        profileTableViewHeader.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }

}

private extension ProfileViewController {

    @objc
    func didTapLeftBarButtomItem(_ sender: UIBarButtonItem) {
        
    }

    @objc
    func didTapRightBarButtomItem(_ sender: UIBarButtonItem) {

    }

}

private extension ProfileViewController {

    func presentAlert() {
        let alert = UIAlertController(
            title: "준비중~",
            message: nil,
            preferredStyle: .alert
        )

        let confirm = UIAlertAction(
            title: "확인",
            style: .cancel
        )

        alert.addAction(confirm)

        present(alert, animated: true)
    }

}
