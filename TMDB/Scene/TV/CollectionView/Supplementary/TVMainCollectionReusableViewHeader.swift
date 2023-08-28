//
//  TVMainCollectionReusableViewHeader.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import SnapKit
import UIKit

class TVMainCollectionReusableViewHeader: UICollectionReusableView {
    // MARK: - View
    let titleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(
            ofSize: 20,
            weight: .medium
        )
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        initalAttributes()
        initalHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind
    func bind(_ title: String) {
        titleLabel.text = title
    }

}

// MARK: - UI
extension TVMainCollectionReusableViewHeader {

    func initalAttributes() {
        backgroundColor = .clear
    }

    func initalHierarchy() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }

}
