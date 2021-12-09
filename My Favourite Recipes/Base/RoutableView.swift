//
//  RoutableView.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import Foundation
import SwiftUI

protocol RoutableView: View {
  associatedtype Router: Routing
 
  var router: Router { get }
}
