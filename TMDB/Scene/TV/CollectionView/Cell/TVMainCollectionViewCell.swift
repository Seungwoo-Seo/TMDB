//
//  TVMainCollectionViewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import Kingfisher
import SnapKit
import UIKit

final class TVMainCollectionViewCell: UICollectionViewCell {
    // MARK: - View
    let posterImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .systemIndigo
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    let rankingLabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        initalAttributes()
        initalHierarhcy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(
        _ tv: TVSeries,
        isRanking: Bool = false,
        item: Int = 0
    ) {
        posterImageView.kf.setImage(
            with: tv.posterURL,
            placeholder: UIImage(systemName: "tv.fill")
        )

        if isRanking {
            rankingLabel.isHidden = false
            let attributes: [NSAttributedString.Key: Any] = [
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white,
                .strokeWidth: -2.0,
                .font: UIFont.boldSystemFont(ofSize: 40.0)
            ]
            let attrString = NSAttributedString(
                string: "\(item)",
                attributes: attributes
            )
            rankingLabel.attributedText = attrString
            rankingLabel.sizeToFit()
        } else {
            rankingLabel.isHidden = true
        }
    }

}

// MARK: - UI
extension TVMainCollectionViewCell {

    func initalAttributes() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func initalHierarhcy() {
        [
            posterImageView,
            rankingLabel
        ].forEach { contentView.addSubview($0) }

        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        rankingLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.leading).inset(8)
            make.bottom.equalTo(posterImageView.snp.bottom)
        }
    }

}
