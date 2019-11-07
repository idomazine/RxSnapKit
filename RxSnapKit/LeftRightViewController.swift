//
//  LeftRightViewController.swift
//  RxSnapKit
//
//  Created by ido on 2019/11/07.
//  Copyright © 2019 ido. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class LeftRightViewController: UIViewController {
    private var boxView: UIView!
    private var leftButton: UIButton!
    private var rightButton: UIButton!

    private let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "LR"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemPurple
        boxView = {
            let boxView = UIView()
            boxView.backgroundColor = .systemGreen
            view.addSubview(boxView)
            boxView.snp.makeConstraints {
                $0.width.height.equalTo(44)
                $0.centerX.equalToSuperview().priority(.high)
                $0.centerY.equalToSuperview()
            }
            return boxView
        }()

        leftButton = {
            let leftButton = UIButton()
            view.addSubview(leftButton)
            leftButton.setTitleColor(.white, for: .normal)
            leftButton.setTitle("Left", for: .normal)
            leftButton.snp.makeConstraints {
                $0.left.equalToSuperview().inset(20)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
            return leftButton
        }()

        rightButton = {
            let rightButton = UIButton()
            view.addSubview(rightButton)
            rightButton.setTitleColor(.white, for: .normal)
            rightButton.setTitle("Right", for: .normal)
            rightButton.snp.makeConstraints {
                $0.right.equalToSuperview().inset(20)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
            return rightButton
        }()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let alignsLeft: Observable<Bool> = Observable.merge(leftButton.rx.tap.map { _ in true },
                                                            rightButton.rx.tap.map { _ in false})
        // Observableで流れてくる値に応じてConstraintを切り替えている
        alignsLeft
            .bind(to: boxView.rx.makeConstraints { maker, alignsLeft in
                if alignsLeft {
                    maker.left.equalToSuperview().inset(10)
                } else {
                    maker.right.equalToSuperview().inset(10)
                }
            })
        .disposed(by: disposeBag)
    }
}
