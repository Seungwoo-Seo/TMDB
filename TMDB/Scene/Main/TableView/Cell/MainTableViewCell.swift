//
//  MainTableViewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    // MARK: - View
    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        configureHierarchy()
    }

}

// MARK: - UI: awakeFromNib
extension MainTableViewCell: UI_CellConvention {

    func configureHierarchy() {
        configureLabels()
        configureViews()
        configureButtons()
        configureImageViews()
    }

    func configureLabels() {
        // releaseDataLabel
        releaseDataLabel.font = .systemFont(ofSize: 15)
        releaseDataLabel.textColor = .secondaryLabel

        // genreLabel
        genreLabel.font = .boldSystemFont(ofSize: 20)
        genreLabel.textColor = .label

        // ratingTitleLabel
        ratingTitleLabel.font = .systemFont(ofSize: 15)
        ratingTitleLabel.textColor = .white
        ratingTitleLabel.backgroundColor = .systemIndigo

        // ratingLabel
        ratingLabel.font = .systemFont(ofSize: 15)
        ratingLabel.textColor = .label
        ratingLabel.backgroundColor = .white

        // titleLabel
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .label

        // overviewLabel
        overviewLabel.font = .systemFont(ofSize: 15)
        overviewLabel.textColor = .secondaryLabel

        // detailLabel
        detailLabel.font = .systemFont(ofSize: 15)
        detailLabel.textColor = .label
    }

    func configureViews() {
        // containerView
        containerView.backgroundColor = .clear
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 1
        containerView.layer.shadowOffset = CGSize(
            width: 10,
            height: 10
        )

        // infoContainerView
        infoContainerView.layer.cornerRadius = 8
        infoContainerView.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        infoContainerView.layer.masksToBounds = true

        // separatorView
        separatorView.backgroundColor = .black
    }

    func configureButtons() {
        // clipButton
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        config.baseForegroundColor = .black
        config.background.backgroundColor = .white
        config.image = UIImage(systemName: "paperclip")
        config.title = ""
        clipButton.configuration = config
    }

    func configureImageViews() {
        // posterImageView
        posterImageView.contentMode = .scaleToFill

        // detailImageView
        detailImageView.contentMode = .scaleAspectFit
        detailImageView.image = UIImage(
            systemName: "chevron.right"
        )
    }

}
