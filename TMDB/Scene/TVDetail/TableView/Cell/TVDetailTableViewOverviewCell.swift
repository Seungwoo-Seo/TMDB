//
//  TVDetailTableViewOverviewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/22.
//

import SnapKit
import UIKit

final class TVDetailTableViewOverviewCell: UITableViewCell {
    // MARK: - View
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    let firstAirDateAndRatingLabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: 13,
            weight: .medium
        )
        label.textColor = .lightGray
        return label
    }()
    let overviewLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(
            ofSize: 15,
            weight: .medium
        )
        label.textColor = .lightText
        return label
    }()
    let contentSegmentedControl = {
        let control = UISegmentedControl(
            items: [
                "회차",
                "함께 시청된 콘텐츠",
                "예고편 및 다른 영상"
            ]
        )
        control.selectedSegmentIndex = 0
        control.apportionsSegmentWidthsByContent = true

        return control
    }()

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
        initalHierarhcy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(tvSeriesDetail: TVSeriesDetail?) {
        guard let tvSeriesDetail else {return}
        titleLabel.text = tvSeriesDetail.name
        firstAirDateAndRatingLabel.text =
        "\(tvSeriesDetail.ratingStringValue) | \(tvSeriesDetail.firstAirDate)"
        overviewLabel.text = tvSeriesDetail.overview
    }

}

// MARK: - UI
extension TVDetailTableViewOverviewCell {

    func initalAttributes() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }

    func initalHierarhcy() {
        [
            titleLabel,
            firstAirDateAndRatingLabel,
            overviewLabel,
            contentSegmentedControl
        ].forEach { contentView.addSubview($0) }

        let spacing: CGFloat = 8
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(spacing * 2)
            make.horizontalEdges.equalToSuperview().inset(spacing)
        }

        firstAirDateAndRatingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(spacing * 2)
            make.horizontalEdges.equalToSuperview().inset(spacing)
        }

        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(firstAirDateAndRatingLabel.snp.bottom).offset(spacing)
            make.horizontalEdges.equalToSuperview().inset(spacing)
        }

        contentSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(spacing * 2)
            make.leading.equalToSuperview().inset(spacing)
            make.trailing.lessThanOrEqualToSuperview().inset(spacing)
            make.bottom.equalToSuperview().inset(spacing * 2)
        }
    }

}
