//
//  ProfileTableViewCell.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/29.
//

import SnapKit
import UIKit

enum ProfileTableViewCellKind: Int, CaseIterable {
    case 이름
    case 사용자_이름
    case 성별_대명사
    case 소개
    case 링크
    case 성별
    case 프로페셔널_계정으로_전환
    case 개인정보_설정

    var title: String {
        switch self {
        case .이름: return "이름"
        case .사용자_이름: return "사용자 이름"
        case .성별_대명사: return "성별 대명사"
        case .소개: return "소개"
        case .링크: return "링크"
        case .성별: return "성별"
        case .프로페셔널_계정으로_전환: return "프로페셔널 게정으로 전환"
        case .개인정보_설정: return "개인정보 설정"
        }
    }

    var placeholder: String? {
        switch self {
        case .이름: return "이름"
        case .사용자_이름: return "사용자 이름"
        case .성별_대명사: return "성별 대명사"
        case .소개: return "소개"
        case .링크: return "링크 추가"
        case .성별: return "성별"
        case .프로페셔널_계정으로_전환: return nil
        case .개인정보_설정: return nil
        }
    }

    var isInnerStackView: Bool {
        switch self {
        case .프로페셔널_계정으로_전환, .개인정보_설정: return false
        default: return true
        }
    }

    var isAccessory: Bool {
        switch self {
        case .링크, .성별: return true
        default: return false
        }
    }

    var isColorWhite: Bool {
        switch self {
        case .프로페셔널_계정으로_전환, .개인정보_설정: return false
        default: return true
        }
    }

    var isSeperatorInset: Bool {
        switch self {
        case .사용자_이름, .성별_대명사, .소개, .링크: return true
        default: return false
        }
    }
}

final class ProfileTableViewCell: UITableViewCell {
    // MARK: - View
    private let separatorView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    private let containerStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    private let titleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(
            ofSize: 15,
            weight: .medium
        )
        return label
    }()
    private let innerStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    private let valueLabel = {
        let label = UILabel()
        label.textColor = .lightText
        label.font = .systemFont(
            ofSize: 15,
            weight: .medium
        )
        return label
    }()
    private let accessoryImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.setContentHuggingPriority(
            .init(1000),
            for: .horizontal
        )
        return imageView
    }()

    // MARK: - Init
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        initalAttirbutes()
        initalHierarhcy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(to kind: ProfileTableViewCellKind) {
        titleLabel.text = kind.title

        if kind.isInnerStackView {
            valueLabel.text = kind.placeholder
        } else {
            innerStackView.isHidden = true
        }

        if kind.isAccessory {
            accessoryImageView.isHidden = false
        } else {
            accessoryImageView.isHidden = true
        }

        if kind.isColorWhite {
            titleLabel.textColor = .white
        } else {
            titleLabel.textColor = .systemBlue
        }

        if kind.isSeperatorInset {
            let inset: CGFloat = 16 + 80 + 8
            separatorView.snp.updateConstraints { make in
                make.leading.equalToSuperview().inset(inset)
            }
        } else {
            separatorView.snp.updateConstraints { make in
                make.leading.equalToSuperview()
            }
        }
    }

}

private extension ProfileTableViewCell {

    func initalAttirbutes() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func initalHierarhcy() {
        [
            separatorView,
            containerStackView
        ].forEach { contentView.addSubview($0) }

        [
            titleLabel,
            innerStackView
        ].forEach { containerStackView.addArrangedSubview($0) }

        [
            valueLabel,
            accessoryImageView
        ].forEach { innerStackView.addArrangedSubview($0) }

        separatorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }

        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }

}
