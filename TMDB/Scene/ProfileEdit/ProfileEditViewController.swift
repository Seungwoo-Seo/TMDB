//
//  ProfileEditViewController.swift
//  TMDB
//
//  Created by 서승우 on 2023/08/30.
//

import SnapKit
import TextFieldEffects
import UIKit

final class ProfileEditViewController: UIViewController {
    // MARK: - View
    private lazy var rightBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButtonItem)
        )
        barButtonItem.isEnabled = false
        return barButtonItem
    }()
    private lazy var hosiTextField = {
        let textField = HoshiTextField(frame: .zero)
        textField.placeholderColor = .lightGray
        textField.borderInactiveColor = .lightGray
        textField.borderActiveColor = .white
        textField.placeholderFontScale = 0.85
        textField.tintColor = .white
        textField.textColor = .white
        textField.delegate = self

        let clearButtom = UIButton(type: .custom)
        let image = UIImage(
            systemName: "xmark.circle.fill"
        )?.withTintColor(
            .lightGray,
            renderingMode: .alwaysOriginal
        )
        clearButtom.setImage(image, for: .normal)
        clearButtom.addTarget(
            self,
            action: #selector(didTapClearButton),
            for: .touchUpInside
        )
        clearButtom.sizeToFit()

        textField.rightView = clearButtom
        textField.rightViewMode = .whileEditing

        return textField
    }()

    var completion: ((String) -> ())?

    // MARK: - Data
    var kind: ProfileTableViewCellKind?

    override func viewDidLoad() {
        super.viewDidLoad()

        initalAttributes()
        initalHierarhcy()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        hosiTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        tabBarController?.tabBar.isHidden = false
    }

    func bind(to kind: ProfileTableViewCellKind) {
        navigationItem.title = kind.title
        hosiTextField.placeholder = kind.placeholder
    }

}

extension ProfileEditViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if range.location == 0 && range.length >= 1 {
            rightBarButtonItem.isEnabled = false
            return true
        }

        let text = textField.text ?? ""
        let result = text + string

        if result.trimmingCharacters(in: .whitespaces).isEmpty {
            rightBarButtonItem.isEnabled = false
        } else {
            rightBarButtonItem.isEnabled = true
        }

        return true
    }

}

private extension ProfileEditViewController {

    func initalAttributes() {
        view.backgroundColor = .black
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapView)
        )
        view.addGestureRecognizer(tap)

        tabBarController?.tabBar.isHidden = true
    }

    func initalHierarhcy() {
        navigationItem.rightBarButtonItem = rightBarButtonItem
        view.addSubview(hosiTextField)

        hosiTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
    }

}

private extension ProfileEditViewController {

    @objc
    func didTapRightBarButtonItem(
        _ sender: UIBarButtonItem
    ) {
        completion?(hosiTextField.text ?? "")
        navigationController?.popViewController(
            animated: true
        )
    }

    @objc
    func didTapView() {
        view.endEditing(true)
    }

    @objc
    func didTapClearButton() {
        hosiTextField.text = ""
    }

}
