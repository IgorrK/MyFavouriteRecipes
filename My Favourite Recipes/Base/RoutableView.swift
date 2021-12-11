//
//  RoutableView.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//

import Foundation
import SwiftUI

protocol RoutableView: View {
  associatedtype Router: Routing
 
  var router: Router { get }
}
