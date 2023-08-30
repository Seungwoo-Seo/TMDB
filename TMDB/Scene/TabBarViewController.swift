//
//  TabBarViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/29.
//

import UIKit

enum TabBarItem: CaseIterable {
    case movie
    case tv
    case profile

    var viewController: UIViewController {
        let vc: UIViewController
        switch self {
        case .movie:
            vc = UINavigationController(
                rootViewController: MovieMainViewController()
            )
            vc.tabBarItem = UITabBarItem(
                title: "Movie",
                image: UIImage(
                    systemName: "popcorn"
                ),
                selectedImage: UIImage(
                    systemName: "popcorn"
                )
            )
        case .tv:
            vc = UINavigationController(
                rootViewController: TVMainViewController()
            )
            vc.tabBarItem = UITabBarItem(
                title: "TV",
                image: UIImage(
                    systemName: "tv"
                ),
                selectedImage: UIImage(
                    systemName: "tv"
                )
            )
        case .profile:
            vc = UINavigationController(
                rootViewController: ProfileViewController()
            )
            vc.tabBarItem = UITabBarItem(
                title: "Profile",
                image: UIImage(
                    systemName: "person"
                ),
                selectedImage: UIImage(
                    systemName: "person"
                )
            )
        }

        return vc
    }
}

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = TabBarItem.allCases.map { $0.viewController }
    }

}
