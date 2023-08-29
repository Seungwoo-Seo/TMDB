//
//  ProfileTableViewHeader.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/30.
//

import SnapKit
import UIKit

final class ProfileTableViewHeader: UIView {
    // MARK: - View
    private let imageStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.setContentHuggingPriority(.init(250), for: .vertical)
        return stackView
    }()
    private let profileImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .white
        return imageView
    }()
    private let avatarImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    private let updateButton = {
        var config = UIButton.Configuration.plain()
        config.title = "사진 또는 아바타 수정"
        let button = UIButton(configuration: config)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initalAttributes()
        initalHierarhcy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension ProfileTableViewHeader {

    func initalAttributes() {

    }

    func initalHierarhcy() {
        [
            imageStackView,
            updateButton
        ].forEach { addSubview($0) }

        [
            profileImageView,
            avatarImageView
        ].forEach { imageStackView.addArrangedSubview($0) }

        let inset: CGFloat = 16
        imageStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(inset)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }

        profileImageView.snp.makeConstraints { make in
            make.width.equalTo(profileImageView.snp.height)
        }

        avatarImageView.snp.makeConstraints { make in
            make.width.equalTo(avatarImageView.snp.height)
        }

        updateButton.snp.makeConstraints { make in
            make.top.equalTo(imageStackView.snp.bottom).offset(inset)
            make.bottom.equalToSuperview().inset(inset)
            make.centerX.equalTo(imageStackView.snp.centerX)
        }
    }

}
