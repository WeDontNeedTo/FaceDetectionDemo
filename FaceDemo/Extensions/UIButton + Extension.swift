//
//  UIButton + Extension.swift
//  FaceDemo
//
//  Created by Danil on 06.08.2021.
//

import Foundation
import UIKit

extension UIButton {
    convenience init(buttonTitle: String, buttonBackground: UIColor) {
        self.init()
        self.setTitle(buttonTitle, for: .normal)
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.textColor = .white
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.backgroundColor = buttonBackground
        self.clipsToBounds = false
        self.layer.cornerRadius = 10
    }
}
