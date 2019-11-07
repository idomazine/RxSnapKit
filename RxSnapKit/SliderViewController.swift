//
//  SliderViewController.swift
//  RxSnapKit
//
//  Created by ido on 2019/11/07.
//  Copyright © 2019 ido. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SliderViewController: UIViewController {
    private var flexibleView: UIView!
    private var centerXCnstraint: Constraint!
    private var slider: UISlider!

    private let disposeBag = DisposeBag()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "Slider"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemPurple

        flexibleView = {
            let flexibleView = UIView()
            flexibleView.backgroundColor = .systemPink
            view.addSubview(flexibleView)
            flexibleView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.height.width.equalTo(44)
                centerXCnstraint = $0.centerX.equalToSuperview().constraint
            }
            return flexibleView
        }()

        slider = {
            let slider = UISlider()
            slider.minimumValue = -50
            slider.maximumValue = 50
            slider.value = 0
            slider.minimumTrackTintColor = .systemRed
            slider.maximumTrackTintColor = .systemBlue
            view.addSubview(slider)
            slider.snp.makeConstraints {
                $0.top.equalTo(flexibleView.snp.bottom).offset(10)
                $0.width.equalToSuperview().offset(-20)
                $0.centerX.equalToSuperview()
            }
            return slider
        }()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Sliderの値をConstraintのoffset値にバインドしている
        slider.rx.value
            .bind(to: centerXCnstraint.rx.offset)
            .disposed(by: disposeBag)
    }
}
