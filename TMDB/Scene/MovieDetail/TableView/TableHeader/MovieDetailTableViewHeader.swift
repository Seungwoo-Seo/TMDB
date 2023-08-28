//
//  MovieDetailTableViewHeader.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/28.
//

import SnapKit
import UIKit

final class MovieDetailTableViewHeader: UIView {
    // MARK: - View
    let backdropImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: 24,
            weight: .black
        )
        label.textColor = .white
        return label
    }()
    let posterImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initalHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension MovieDetailTableViewHeader {

    func initalHierarchy() {
        [
            backdropImageView,
            titleLabel,
            posterImageView
        ].forEach { addSubview($0) }

        backdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.horizontalEdges.equalToSuperview().inset(16)
        }

        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(100)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.75)
        }
    }

}
