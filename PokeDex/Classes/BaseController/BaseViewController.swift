//
//  BaseViewController.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {
    enum NavigationBarStyle {
        case transparent
        case white
        case custom(color: UIColor)
    }
}

class BaseViewController: UIViewController {
    var notificationManager = NotificationManager()
    var disposeBag: DisposeBag = DisposeBag() // RX
    var navigationBarStyle: UIViewController.NavigationBarStyle = .white

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let navigationBar = navigationController?.navigationBar else {
            return
        }

        switch navigationBarStyle {
        case .transparent:
            navigationBar.style(backgroundColor: .clear, titleColor: .black)
            navigationBar.isTranslucent = true
            navigationBar.barStyle = .blackTranslucent
        case .white:
            navigationBar.style(backgroundColor: .white, titleColor: .black)
            navigationBar.isTranslucent = false
            navigationBar.barStyle = .default
        case let .custom(color):
            navigationBar.style(backgroundColor: color, titleColor: .white)
            navigationBar.isTranslucent = false
            navigationBar.barStyle = .default
        }
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        notificationManager.deregisterAll()
        super.dismiss(animated: flag, completion: completion)
    }

    deinit {
        disposeBag = DisposeBag()
        notificationManager.deregisterAll()
        NotificationCenter.default.removeObserver(self)
        print("*********Deallocating \(Mirror(reflecting: self).subjectType) ****************")
    }
}
