//
//  MultiRouteCoordinator.swift
//  Router
//
//  Created by Carl Funk on 3/9/22.
//  Copyright © 2022 Carl Funk. All rights reserved.
//

import Foundation

/// Protocol that represents a coordinator responsible for providing other single route coordinators
public protocol MultiRouteCoordinator: RouteCoordinator {
    /// Dictionary of single route coordinators that can be retrieved via identifiers
    var routeCoordinatorsByIdentifier: [String: SingleRouteCoordinator.Type] { get }
    
    init(parent: RouteCoordinator?)
}

public extension MultiRouteCoordinator {
    func routeCoordinator(for route: Route) -> SingleRouteCoordinator.Type? {
        if let routeCoordinator = routeCoordinatorsByIdentifier[route.identifier] {
            return routeCoordinator
        } else {
            return parent?.routeCoordinator(for: route)
        }
    }
}
