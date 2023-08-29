//
//  PosterContainerView.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/28.
//

import SnapKit
import UIKit

final class PosterContainerView: UIView {
    // MARK: - View
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .systemIndigo
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    let clipButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        config.baseForegroundColor = .black
        config.background.backgroundColor = .white
        config.image = UIImage(systemName: "paperclip")
        config.title = ""
        let button = UIButton(configuration: config)
        return button
    }()
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0

        return stackView
    }()
    private let ratingTitleLabel: PaddingLabel = {
        let label = PaddingLabel(frame: .zero)
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .systemIndigo
        label.text = "평점"
        return label
    }()
    let ratingLabel: PaddingLabel = {
        let label = PaddingLabel(frame: .zero)
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .label
        label.backgroundColor = .white
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        initalHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension PosterContainerView {

    func initalHierarchy() {
        [
            posterImageView,
            clipButton,
            ratingStackView
        ].forEach { addSubview($0) }

        [
            ratingTitleLabel,
            ratingLabel
        ].forEach { ratingStackView.addArrangedSubview($0) }

        let inset: CGFloat = 16
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.height.equalTo(posterImageView.snp.width)
        }

        clipButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(inset)
        }

        ratingStackView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(inset)
        }
    }

}
