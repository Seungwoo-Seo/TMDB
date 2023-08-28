//
//  DetailTableViewCastCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import Kingfisher
import SnapKit
import UIKit

final class DetailTableViewCastCell: UITableViewCell {
    // MARK: - View
    let profireImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    let labelStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    let nameLabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )
        label.textColor = .white
        return label
    }()
    let additionalInfoLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightText
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
    func bind(_ cast: Cast) {
        profireImageView.kf.setImage(
            with: cast.profireURL,
            placeholder: UIImage(systemName: "person.fill")
        )
        nameLabel.text = cast.name

        if let character = cast.character {
            additionalInfoLabel.text = "\(cast.originalName) / \(character)"
        } else {
            additionalInfoLabel.text = "\(cast.originalName)"
        }
    }
    
}

// MARK: - UI
extension DetailTableViewCastCell {

    func initalAttributes() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func initalHierarchy() {
        [
            profireImageView,
            labelStackView
        ].forEach { contentView.addSubview($0) }

        [
            nameLabel,
            additionalInfoLabel
        ].forEach { labelStackView.addArrangedSubview($0) }

        profireImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(16)
            make.height.equalTo(60)
            make.width.equalTo(profireImageView.snp.height).multipliedBy(0.75)
        }

        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(profireImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(profireImageView.snp.centerY)
        }
    }

}
