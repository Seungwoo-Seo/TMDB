//
//  DetailTableViewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import UIKit

protocol DetailTableViewOverviewCellDelegate: AnyObject {
    func didTapExpandButton(
        _ sender: UIButton,
        overviewLabel: UILabel
    )
}

final class DetailTableViewOverviewCell: UITableViewCell {
    // MARK: - View
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!

    // MARK: - Delegate
    weak var delegate: DetailTableViewOverviewCellDelegate?

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        configureHierarchy()
    }

    // MARK: - Bind
    func bind(_ trending: Movie) {
        overviewLabel.text = trending.overview
    }

    // MARK: - Event
    @IBAction func didTapExpandButton(_ sender: UIButton) {
        delegate?.didTapExpandButton(
            sender,
            overviewLabel: overviewLabel
        )
    }

}

// MARK: - UI: awakeFromNib
extension DetailTableViewOverviewCell: UI_CellConvention {

    func configureHierarchy() {
        configureCell()
        configureLabels()
        configureButtons()
    }

    func configureCell() {
        selectionStyle = .none
    }

    func configureLabels() {
        overviewLabel.font = .systemFont(
            ofSize: 15,
            weight: .medium
        )
        overviewLabel.textColor = .label
        overviewLabel.numberOfLines = 2
    }

    func configureButtons() {
        var config = UIButton.Configuration.plain()
        config.title = ""
        config.image = UIImage(systemName: "chevron.down")
        config.baseForegroundColor = .label

        expandButton.configuration = config
        expandButton.configurationUpdateHandler = { button in
            if button.isSelected {
                button.configuration?.baseForegroundColor = .label
                button.configuration?.background.backgroundColor = .clear
                button.configuration?.image = UIImage(
                    systemName: "chevron.up"
                )
            } else {
                button.configuration?.baseForegroundColor = .label
                button.configuration?.background.backgroundColor = .clear
                button.configuration?.image = UIImage(
                    systemName: "chevron.down"
                )
            }
        }
    }

}
