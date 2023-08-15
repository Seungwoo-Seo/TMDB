//
//  UIViewController+.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import UIKit.UIViewController

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}
