//
//  TVMainCollectionViewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/19.
//

import Kingfisher
import UIKit

final class TVMainCollectionViewCell: UICollectionViewCell {
    // MARK: - View
    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureHierarchy()
    }

    func bind(_ tv: TV) {
        posterImageView.kf.setImage(with: tv.posterURL)
    }

}

// MARK: - UI: awakeFromNib
extension TVMainCollectionViewCell: UI_CellConvention {

    func configureHierarchy() {
        configureImageViews()
    }

    func configureImageViews() {
        posterImageView.contentMode = .scaleToFill
    }

}
