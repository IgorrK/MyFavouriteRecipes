//
//  UIScreen.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 10.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
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
