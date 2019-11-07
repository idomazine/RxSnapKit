//
//  SnapKit+Rx.swift
//  RxSnapKit
//
//  Created by ido on 2019/11/07.
//  Copyright © 2019 ido. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit

extension Constraint: ReactiveCompatible { }

extension Reactive where Base: Constraint {
    var isActive: Binder<Bool> {
        Binder(base) { constraint, isActive in
            constraint.isActive = isActive
        }
    }
    
    var offset: Binder<Float> {
        Binder(base) { constraint, offset in
            constraint.update(offset: offset)
        }
    }
    
    var inset: Binder<Float> {
        Binder(base) { constraint, inset in
            constraint.update(inset: inset)
        }
    }
    
    var priority: Binder<ConstraintPriority> {
        Binder(base) { constraint, priority in
            constraint.update(priority: priority)
        }
    }
}

extension Reactive where Base: UIView {
    /// Rxで流れた値に応じたConstarintを定義する
    ///
    /// - Parameters:
    ///   - makes: Constraintの定義を行うクロージャ
    /// - Returns: Binder
    func makeConstraints<T>(makes: @escaping ((ConstraintMaker, T) -> Void)) -> Binder<T> {
        var constraints: [Constraint] = []
        return Binder(base) { view, value in
            constraints.forEach { $0.deactivate() }
            constraints = view.snp.prepareConstraints { maker in makes(maker, value) }
            constraints.forEach { $0.activate() }
        }
    }
}
