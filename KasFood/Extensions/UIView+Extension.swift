//
//  UIView+Extension.swift
//  KasFood
//
//  Created by Aziz Zhandar on 27.06.2022.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}
