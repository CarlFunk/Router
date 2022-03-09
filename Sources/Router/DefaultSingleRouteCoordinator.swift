//
//  DefaultSingleRouteCoordinator.swift
//  Router
//
//  Created by Carl Funk on 3/9/22.
//  Copyright © 2022 Carl Funk. All rights reserved.
//

import SwiftUI

/// Default single route coordinator that can be subclassed to return the view related to a route.
open class DefaultSingleRouteCoordinator: ObservableRouteCoordinator {
    @Published public var route: Route?
    @Published public var nextRoute: Route?
    @Published public var isActive: Bool
    
    public weak var parent: RouteCoordinator?
    
    required public init() {
        self.parent = nil
        self.nextRoute = nil
        self.isActive = false
    }
    
    /// Returns the view associated with a route.
    ///
    /// Important: Override when subclassing
    ///
    open func routeView() -> AnyView {
        fatalError("Implement a route view")
    }
}
