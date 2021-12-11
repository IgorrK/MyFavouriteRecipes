//
//  UIScreen.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 10.12.2021.
//

import Foundation
import UIKit

extension UIScreen {
    struct Geometry {
        static var size: CGSize { UIScreen.main.bounds.size }
        static var width: CGFloat { size.width }
        static var height: CGFloat { size.height }
    }
}
