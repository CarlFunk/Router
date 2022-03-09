//
//  DefaultMultiRouteCoordinator.swift
//  Router
//
//  Created by Carl Funk on 3/9/22.
//  Copyright © 2022 Carl Funk. All rights reserved.
//

import Foundation

/// Default multi route coordinator that can be subclassed to return a list of single route coordinators via identifiers
open class DefaultMultiRouteCoordinator: MultiRouteCoordinator {
    open var routeCoordinatorsByIdentifier: [String : SingleRouteCoordinator.Type] {
        return [:]
    }
    
    public required init(parent: RouteCoordinator?) {
        self.parent = parent
    }
    
    public var parent: RouteCoordinator?
}
