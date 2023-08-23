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
    @IBOutlet weak var rankingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureHierarchy()
    }

    func bind(_ tv: TVSeries, isRanking: Bool = false, item: Int = 0) {
        posterImageView.kf.setImage(with: tv.posterURL)

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

// MARK: - UI: awakeFromNib
extension TVMainCollectionViewCell: UI_CellConvention {

    func configureHierarchy() {
        configureImageViews()
        configureLabels()
    }

    func configureImageViews() {
        posterImageView.contentMode = .scaleToFill
        posterImageView.layer.cornerRadius = 8
    }

    func configureLabels() {
        rankingLabel.isHidden = true
        rankingLabel.textAlignment = .center
    }

}
