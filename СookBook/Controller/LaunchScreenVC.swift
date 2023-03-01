//
//  LaunchScreenVC.swift
//  СookBook
//
//  Created by Vladimir V. on 28.02.2023.
//

import Foundation
import UIKit

final class LaunchScreenVC : UIViewController {
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
        view.addSubview(button)
        button.center = view.center
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Launch Screen", for: .normal)
    }
    @objc func didTapButton() {
        coordinator?.eventOccurred(with: .startTapped)
    }
}
