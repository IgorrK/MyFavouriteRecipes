//
//  Typealiases.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 11.12.2021.
//

import Foundation

typealias Completion = () -> Void
typealias Callback<T> = (T) -> Void
typealias ResultCallback<T> = Callback<Result<T, Error>>
