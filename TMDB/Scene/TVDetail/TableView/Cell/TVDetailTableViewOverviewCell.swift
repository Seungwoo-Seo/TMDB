//
//  TVDetailTableViewOverviewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/22.
//

import UIKit

final class TVDetailTableViewOverviewCell: UITableViewCell {
    // MARK: - View
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstAirDateAndRatingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var contentSegmentedControl: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureHierarchy()
    }

    func bind(_ tvSeriesDetail: TVSeriesDetail?) {
        guard let tvSeriesDetail else {return}
        titleLabel.text = tvSeriesDetail.name
        firstAirDateAndRatingLabel.text =
        "\(tvSeriesDetail.voteAverage) | \(tvSeriesDetail.firstAirDate)"
        overviewLabel.text = tvSeriesDetail.overview
    }

}

extension TVDetailTableViewOverviewCell: UI_CellConvention {

    func configureHierarchy() {
        configureLabels()
        configureSegmentedControls()
    }

    func configureLabels() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .label

        firstAirDateAndRatingLabel.font = .systemFont(
            ofSize: 13,
            weight: .medium
        )
        firstAirDateAndRatingLabel.textColor = .secondaryLabel

        overviewLabel.font = .systemFont(
            ofSize: 15,
            weight: .medium
        )
        overviewLabel.textColor = .label
    }

    func configureSegmentedControls() {
        
    }

}
