//
//  UIButton+Scaling.swift
//  PairGame
//
//  Created by jjurlits on 4/28/21.
//

import UIKit

extension UIButton {
    func scaleImageToFill() {
        self.imageView?.contentMode = .scaleAspectFill
    }
}
