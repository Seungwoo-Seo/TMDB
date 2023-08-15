//
//  UITableViewCell+.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import UIKit.UITableViewCell

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
