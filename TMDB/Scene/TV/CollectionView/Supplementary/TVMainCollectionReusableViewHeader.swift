//
//  TVMainCollectionReusableViewHeader.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import UIKit

class TVMainCollectionReusableViewHeader: UICollectionReusableView {
    // MARK: - View
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        configureHierarchy()
    }

    // MARK: - Bind
    func bind(_ title: String) {
        titleLabel.text = title
    }

}

// MARK: - UI: awakeFromNib
extension TVMainCollectionReusableViewHeader: UI_ViewConvention {

    func configureHierarchy() {
        configureLabels()
    }

    func configureLabels() {
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(
            ofSize: 20,
            weight: .medium
        )
    }

}
