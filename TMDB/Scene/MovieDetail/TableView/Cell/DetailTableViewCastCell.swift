//
//  DetailTableViewCastCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import Kingfisher
import UIKit

final class DetailTableViewCastCell: UITableViewCell {
    // MARK: - View
    @IBOutlet weak var profireImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var additionalInfoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureHierarchy()
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

// MARK: - UI: awakeFromNib
extension DetailTableViewCastCell: UI_CellConvention {

    func configureHierarchy() {
        configureCell()
        configureImageViews()
        configureLabels()
    }

    func configureCell() {
        selectionStyle = .none
    }

    func configureImageViews() {
        // profireImageView
        profireImageView.contentMode = .scaleToFill
        profireImageView.tintColor = .black
        profireImageView.layer.cornerRadius = 8
    }

    func configureLabels() {
        // nameLabel
        nameLabel.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )
        nameLabel.textColor = .label

        // additionalInfoLabel
        additionalInfoLabel.font = .systemFont(ofSize: 13)
        additionalInfoLabel.textColor = .secondaryLabel
    }

}
