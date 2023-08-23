//
//  TVDetailTableViewContentCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/22.
//

import UIKit

final class TVDetailTableViewContentCell: UITableViewCell {
    // MARK: - View
    @IBOutlet weak var stillImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureHierarchy()
    }

}

extension TVDetailTableViewContentCell: UI_CellConvention {

    func configureHierarchy() {

    }

}
