//
//  UIConvention.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import Foundation

/// Storyboard로 UI를 구성할 때 Base(최상위) 컨벤션
@objc
protocol UI_StoryboardConvention {
    /// UI 만드는 방식에 따라 변동
    ///
    /// 스토리보드 - UI 구성 메소드들의 흐름을 담당 ✓
    ///
    /// CodeBase - View들을 추가하고 레이아웃을 설정
    func configureHierarchy()

    // MARK: Bind - 데이터를 뷰에 적용, Life Cycle과 Event 사이에 작성
    @objc optional func bind()
    @objc optional func updatebind()

    // MARK: 복수 불가
    @objc optional func configureRootView()

    // MARK: 복수 가능
    @objc optional func configureViews()
    @objc optional func configureTableViews()
    @objc optional func configureCollectionViews()
    @objc optional func configureImageViews()
    @objc optional func configureLabels()
    @objc optional func configureButtons()
    @objc optional func configureTextFields()
    @objc optional func configureStackViews()
}

/// UIViewController의 UI 구성 컨벤션
///
/// viewDidLoad 시점에 호출
@objc
protocol UI_ViewControllerConvention: UI_StoryboardConvention {
    // MARK: 복수 불가
    @objc optional func configureNavigationBar()
    @objc optional func configureTabBar()
}

/// UITableViewCell, UICollectionViewCell의 UI 구성 컨벤션
///
/// awakeFromNib 시점에 호출
@objc
protocol UI_CellConvention: UI_StoryboardConvention {
    // MARK: 복수 불가
    @objc optional func configureCell()
    @objc optional func configureContentView()
}
