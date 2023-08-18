//
//  MainTableViewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import Kingfisher
import UIKit

protocol MainTableViewCellDelegate: AnyObject {
    func didTapPushButton(_ tag: Int)
}

final class MainTableViewCell: UITableViewCell {
    // MARK: - View
    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var ratingTitleLabel: PaddingLabel!
    @IBOutlet weak var ratingLabel: PaddingLabel!

    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!

    // MARK: - Data
    var pushButtontag: Int?

    // MARK: - Delegate
    weak var delegate: MainTableViewCellDelegate?

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        configureHierarchy()
    }

    func bind(_ trending: Movie) {
        releaseDataLabel.text = trending.releaseDate
        genreLabel.text = trending.genresStringValue
        posterImageView.kf.setImage(
            with: trending.posterURL,
            placeholder: UIImage(
                systemName: "rectangle.on.rectangle"
            )
        )
        ratingLabel.text = trending.ratingStringValue
        titleLabel.text = trending.title
        overviewLabel.text = trending.overview
    }

    // MARK: - Event
    @IBAction func didTapClipButton(_ sender: UIButton) {
        print("clip")
    }

    @IBAction func didTapPushButton(_ sender: UIButton) {
        guard let tag = pushButtontag else {return}
        delegate?.didTapPushButton(tag)
    }

}

// MARK: - UI: awakeFromNib
extension MainTableViewCell: UI_CellConvention {

    func configureHierarchy() {
        configureCell()
        configureLabels()
        configureViews()
        configureButtons()
        configureImageViews()
    }

    func configureCell() {
        selectionStyle = .none
    }

    func configureLabels() {
        // releaseDataLabel
        releaseDataLabel.font = .systemFont(ofSize: 15)
        releaseDataLabel.textColor = .secondaryLabel

        // genreLabel
        genreLabel.font = .boldSystemFont(ofSize: 20)
        genreLabel.textColor = .label

        // ratingTitleLabel
        ratingTitleLabel.font = .systemFont(ofSize: 13)
        ratingTitleLabel.textAlignment = .center
        ratingTitleLabel.textColor = .white
        ratingTitleLabel.backgroundColor = .systemIndigo
        ratingTitleLabel.text = "평점"

        // ratingLabel
        ratingLabel.font = .systemFont(ofSize: 13)
        ratingLabel.textAlignment = .center
        ratingLabel.textColor = .label
        ratingLabel.backgroundColor = .white

        // titleLabel
        titleLabel.font = .systemFont(
            ofSize: 20,
            weight: .medium
        )
        titleLabel.textColor = .label

        // overviewLabel
        overviewLabel.font = .systemFont(ofSize: 15)
        overviewLabel.textColor = .secondaryLabel

        // detailLabel
        detailLabel.font = .systemFont(ofSize: 13)
        detailLabel.textColor = .label
        detailLabel.text = "자세히 보기"
    }

    func configureViews() {
        // containerView
        containerView.backgroundColor = .clear
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 8

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
        posterImageView.tintColor = .systemIndigo
        posterImageView.layer.cornerRadius = 8
        posterImageView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        posterImageView.layer.masksToBounds = true

        // detailImageView
        detailImageView.contentMode = .scaleAspectFit
        detailImageView.tintColor = .label
        detailImageView.image = UIImage(
            systemName: "chevron.right"
        )
    }

}
