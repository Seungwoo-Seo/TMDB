//
//  InfoContainerView.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/28.
//

import SnapKit
import UIKit

final class InfoContainerView: UIView {
    // MARK: - View
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: 20,
            weight: .medium
        )
        label.textColor = .white
        return label
    }()
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lightText
        return label
    }()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "자세히 보기"
        return label
    }()
    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(
            systemName: "chevron.right"
        )
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

private extension InfoContainerView {

    func initalHierarchy() {
        [
            titleLabel,
            overviewLabel,
            separatorView,
            detailLabel,
            detailImageView
        ].forEach { addSubview($0) }

        let spacing: CGFloat = 20
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(spacing)
        }

        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(spacing)
        }

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(spacing)
            make.horizontalEdges.equalToSuperview().inset(spacing - 4)
            make.height.equalTo(1)
        }

        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(spacing)
            make.leading.bottom.equalToSuperview().inset(spacing)
        }

        detailImageView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(spacing)
            make.trailing.bottom.equalToSuperview().inset(spacing)
        }
    }

}
