//
//  PaddingLabel.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/16.
//

import UIKit.UILabel

final class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(
        top: 4.0,
        left: 4.0,
        bottom: 4.0,
        right: 4.0
    )

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
