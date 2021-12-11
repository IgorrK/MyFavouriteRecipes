//
//  Image.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 11.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import Foundation
import SwiftUI

extension Image {

    init?(uiImageOrNil: UIImage?) {
        guard let image = uiImageOrNil else { return nil }
        self = Image(uiImage: image)
    }
}
