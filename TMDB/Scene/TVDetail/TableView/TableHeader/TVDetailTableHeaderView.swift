//
//  TVDetailTableHeaderView.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/26.
//

import Kingfisher
import SnapKit
import UIKit

final class TVDetailTableHeaderView: UIView {
    // MARK: - View
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill

        return imageView
    }()

    let unwindButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.background.backgroundColor = .black
        config.image = UIImage(systemName: "xmark")
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)

        return button
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill

        return imageView
    }()

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind
    func bind(tvSeriesDetail: TVSeriesDetail) {
        print(tvSeriesDetail.posterPath)

        backdropImageView.kf.setImage(
            with: tvSeriesDetail.backdropURL
        )
        posterImageView.kf.setImage(
            with: tvSeriesDetail.posterURL
        )
    }

}

private extension TVDetailTableHeaderView {

    func configureHierarchy() {
        [
            backdropImageView,
            unwindButton
//            posterImageView
        ].forEach { addSubview($0) }

        backdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        unwindButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
        }

//        posterImageView.snp.makeConstraints { make in
//            make.height.equalTo(125)
//            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.75)
//            make.leading.equalToSuperview().inset(16)
//            make.bottom.equalToSuperview()
//        }
    }

}
