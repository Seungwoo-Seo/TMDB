//
//  MainTableViewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/15.
//

import Kingfisher
import SnapKit
import UIKit

protocol MainTableViewCellDelegate: AnyObject {
    func didTapPushButton(_ tag: Int)
}

final class MainTableViewCell: UITableViewCell {
    // MARK: - View
    private let releaseDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lightText
        return label
    }()
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white

        return label
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        return view
    }()
    private let posterContainerView: PosterContainerView = {
        let view = PosterContainerView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    private let infoContainerView: InfoContainerView = {
        let view = InfoContainerView(frame: .zero)
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        view.layer.masksToBounds = true
        view.setContentCompressionResistancePriority(
            .init(1000),
            for: .vertical
        )
        view.setContentHuggingPriority(
            .init(1000),
            for: .vertical
        )

        return view
    }()
    lazy var pushButton = {
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(didTapPushButton),
            for: .touchUpInside
        )
        return button
    }()

    // MARK: - Data
    var pushButtontag: Int?

    // MARK: - Delegate
    weak var delegate: MainTableViewCellDelegate?

    // MARK: - Init
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        initalAttributes()
        initalHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind
    func bind(to movie: Movie) {
        releaseDataLabel.text = movie.releaseDate
        genreLabel.text = movie.genresStringValue
        posterContainerView.posterImageView.kf.setImage(
            with: movie.posterURL,
            placeholder: UIImage(
                systemName: "rectangle.on.rectangle"
            )
        )
        posterContainerView.ratingLabel.text = movie.ratingStringValue
        infoContainerView.titleLabel.text = movie.title
        infoContainerView.overviewLabel.text = movie.overview
    }

}

// MARK: - UI
extension MainTableViewCell {

    func initalAttributes() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func initalHierarchy() {
        [
            releaseDataLabel,
            genreLabel,
            containerView,
            pushButton
        ].forEach { contentView.addSubview($0) }

        // 이거완 별개 아닌가?
        // 우선순위 설정도 다 해줬고
        // 레이아웃도 제대로 설정되어 있었는데
        // 여기서 먼저 추가하는게 이미지가 침범하는 것과 뭔 상관?
        // 버튼도 아니고
        [
            infoContainerView,
            posterContainerView
        ].forEach { containerView.addSubview($0) }

        let margin: CGFloat = 20
        let spacing: CGFloat = 8
        releaseDataLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(margin)
        }

        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDataLabel.snp.bottom).offset(spacing)
            make.horizontalEdges.equalToSuperview().inset(margin)
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(spacing)
            make.horizontalEdges.bottom.equalToSuperview().inset(margin)
            make.height.equalTo(containerView.snp.width).multipliedBy(1.3)
        }

        posterContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }

        infoContainerView.snp.makeConstraints { make in
            make.top.equalTo(posterContainerView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }

        pushButton.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }

}

// MARK: - Event
extension MainTableViewCell {

    @objc
    func didTapClipButton(_ sender: UIButton) {
        print("clip")
    }

    @objc
    func didTapPushButton(_ sender: UIButton) {
        guard let tag = pushButtontag else {return}
        delegate?.didTapPushButton(tag)
    }

}
