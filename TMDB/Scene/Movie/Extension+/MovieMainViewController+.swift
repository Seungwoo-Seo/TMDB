//
//  MovieMainViewController+.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/28.
//

import UIKit

extension MovieMainViewController {
    enum TransitionStyle {
        case push
    }

    func transition<T: UIViewController>(
        viewController: T,
        style: TransitionStyle
    ) {
        switch style {
        case .push:
            navigationController?.pushViewController(
                viewController,
                animated: true
            )
        }
    }

}
