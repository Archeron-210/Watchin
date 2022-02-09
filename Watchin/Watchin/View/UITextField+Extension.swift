//
//  UITextField+Extension.swift
//  Watchin
//
//  Created by Archeron on 09/02/2022.
//

import Foundation
import UIKit

extension UITextField {
    func setBottomBorderAndPlaceholderTextColor() {

        // sets the border :
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)

        // sets the placeholder text color :
        if let placeholder = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
}
