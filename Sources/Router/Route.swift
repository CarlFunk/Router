//
//  Route.swift
//  Router
//
//  Created by Carl Funk on 3/9/22.
//  Copyright © 2022 Carl Funk. All rights reserved.
//

import Foundation

/// Protocol representing a navigation that can be initated from coordinators
public protocol Route {
    /// Unique identifier assigned to a route
    var identifier: String { get }
    
    /// Data to be passed along with the route
    var data: [String: Any] { get }
}
