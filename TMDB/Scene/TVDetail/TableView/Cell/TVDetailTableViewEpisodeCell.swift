//
//  TVDetailTableViewEpisodeCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/22.
//

import Kingfisher
import SnapKit
import UIKit

final class TVDetailTableViewEpisodeCell: UITableViewCell {
    // MARK: - View
    let stillImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    let labelStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    let episodeNameLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(
            ofSize: 17,
            weight: .medium
        )
        return label
    }()
    let runtimeLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(
            ofSize: 15,
            weight: .regular
        )
        return label
    }()
    let overviewLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(
            ofSize: 17,
            weight: .medium
        )
        return label
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
        initalHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind
    func bind(episode: Episode?, posterURL: URL?) {
        guard let episode else {return}

        if let url = episode.stillURL {
            stillImageView.kf.setImage(with: url)
        } else {
            stillImageView.kf.setImage(with: posterURL)
        }

        episodeNameLabel.text = episode.name

        if let runtime = episode.runtime {
            runtimeLabel.text = "\(runtime)분"
        } else {
            runtimeLabel.text = "알수없음"
        }
        overviewLabel.text = episode.overview
    }

}

extension TVDetailTableViewEpisodeCell {

    func initalAttributes() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }

    func initalHierarchy() {
        [
            stillImageView,
            labelStackView,
            overviewLabel
        ].forEach { contentView.addSubview($0) }

        [
            episodeNameLabel,
            runtimeLabel
        ].forEach { labelStackView.addArrangedSubview($0) }

        let spacing: CGFloat = 8
        stillImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(spacing)
            make.height.equalTo(60)
            make.width.equalTo(stillImageView.snp.height).multipliedBy(2)
        }

        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(stillImageView.snp.trailing).offset(spacing)
            make.trailing.equalToSuperview().inset(spacing)
            make.centerY.equalTo(stillImageView.snp.centerY)
        }

        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(stillImageView.snp.bottom).offset(spacing)
            make.horizontalEdges.bottom.equalToSuperview().inset(spacing)
        }
    }

}
