//
//  RouteCoordinator.swift
//  Router
//
//  Created by Carl Funk on 3/9/22.
//  Copyright © 2022 Carl Funk. All rights reserved.
//

import Foundation

/// Protocol representing a route coordinator.  Route coordinators have the ability to obtain a single route coordinator
/// given a route.
public protocol RouteCoordinator: AnyObject {
    /// Reference to a parent route coordinator
    var parent: RouteCoordinator? { get set }
    
    /// Returns a single route coordinator for a route
    func routeCoordinator(for route: Route) -> SingleRouteCoordinator.Type?
}
