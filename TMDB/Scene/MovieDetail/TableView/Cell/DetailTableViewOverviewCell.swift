//
//  DetailTableViewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import SnapKit
import UIKit

protocol DetailTableViewOverviewCellDelegate: AnyObject {
    func didTapExpandButton(
        _ sender: UIButton,
        overviewLabel: UILabel
    )
}

final class DetailTableViewOverviewCell: UITableViewCell {
    // MARK: - View
    let overviewLabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: 15,
            weight: .medium
        )
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    lazy var expandButton = {
        var config = UIButton.Configuration.plain()
        config.title = ""
        config.image = UIImage(
            systemName: "chevron.down"
        )?.withTintColor(
            .white
        )
        config.baseForegroundColor = .white

        let button = UIButton(configuration: config)
        button.addTarget(
            self,
            action: #selector(didTapExpandButton),
            for: .touchUpInside
        )
        button.configurationUpdateHandler = { button in
            if button.isSelected {
                button.configuration?.baseForegroundColor = .white
                button.configuration?.background.backgroundColor = .clear
                button.configuration?.image = UIImage(
                    systemName: "chevron.up"
                )
            } else {
                button.configuration?.baseForegroundColor = .white
                button.configuration?.background.backgroundColor = .clear
                button.configuration?.image = UIImage(
                    systemName: "chevron.down"
                )
            }
        }
        return button
    }()

    // MARK: - Delegate
    weak var delegate: DetailTableViewOverviewCellDelegate?

    // MARK: - Init
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        initalAttributes()
        initalHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind
    func bind(_ trending: Movie) {
        overviewLabel.text = trending.overview
    }

    @objc
    func didTapExpandButton(_ sender: UIButton) {
        delegate?.didTapExpandButton(
            sender,
            overviewLabel: overviewLabel
        )
    }

}

// MARK: - UI
extension DetailTableViewOverviewCell {

    func initalAttributes() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func initalHierarchy() {
        [
            overviewLabel,
            expandButton
        ].forEach { contentView.addSubview($0) }

        overviewLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16)
        }

        expandButton.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
    }

}
