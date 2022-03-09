//
//  SingleRouteCoordinator.swift
//  Router
//
//  Created by Carl Funk on 3/9/22.
//  Copyright © 2022 Carl Funk. All rights reserved.
//

import SwiftUI

/// Protocol that represents a coordinator responsible for single route
public protocol SingleRouteCoordinator: RouteCoordinator {
    /// The current route represented by the current route coordinator
    var route: Route? { get set }
    
    /// The next route representing a navigation
    var nextRoute: Route? { get set }
    
    /// Represents the navigation is active for the next route
    var isActive: Bool { get set }
    
    init()
    init(route: Route, parent: RouteCoordinator?)
    
    /// Returns the view associated with the current route
    func routeView() -> AnyView
    
    /// Returns the view associated with the next route (navigation)
    func nextRouteView() -> AnyView
    
    /// Initiate the navigation to a given route
    func navigate(to route: Route)
    
    /// Initiate a deeplink
    func deeplink(to deeplinkRoute: DeeplinkRoute)
}

public extension SingleRouteCoordinator {
    init(route: Route, parent: RouteCoordinator?) {
        self.init()
        self.route = route
        self.parent = parent
        self.isActive = false
        
        if var deeplinkRoute = route as? DeeplinkRoute {
            deeplinkRoute.moveToNextRoute()
            if deeplinkRoute.canNavigateToNextRoute {
                delayedNavigate(to: deeplinkRoute, with: self)
            }
        }
    }
    
    func navigate(to route: Route) {
        nextRoute = route
        isActive = true
    }
    
    func deeplink(to deeplinkRoute: DeeplinkRoute) {
        let deeplinkHasRoutes = !deeplinkRoute.routes.isEmpty
        var currentParent = parent
        
        // If the parent is not a single route coordinator, the current coordinator is the top most coordinator that could perform the deeplink (navigate)
        if currentParent as? SingleRouteCoordinator == nil {
            isActive = false
            
            if deeplinkHasRoutes {
                navigate(to: deeplinkRoute)
            }
            
            return
        }
        
        // Traverse parents to find the highest single route coordinator and then cancel all navigation at the top level.  After, proceed by navigating to every individual route as defined by the deeplink's routes.
        while currentParent?.parent != nil && (currentParent?.parent as? SingleRouteCoordinator) != nil {
            currentParent = currentParent?.parent
        }
        
        if let singleRouteCoordinator = currentParent as? SingleRouteCoordinator {
            singleRouteCoordinator.isActive = false
            
            if deeplinkHasRoutes {
                delayedNavigate(to: deeplinkRoute, with: singleRouteCoordinator)
            }
        }
    }
    
    func routeCoordinator(for route: Route) -> SingleRouteCoordinator.Type? {
        parent?.routeCoordinator(for: route)
    }
    
    func nextRouteView() -> AnyView {
        guard let nextRoute = nextRoute else {
            return AnyView(EmptyView())
        }
        
        guard let nextRouteCoordinator = routeCoordinator(for: nextRoute) else {
            return AnyView(EmptyView())
        }
        
        return nextRouteCoordinator.init(route: nextRoute, parent: self).routeView()
    }
    
    // Necessary from SwiftUI to wait 1 second between navigations, otherwise SwiftUI has difficulty performing all of them
    private func delayedNavigate(to route: Route, with coordinator: SingleRouteCoordinator) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak coordinator] in
            coordinator?.navigate(to: route)
        }
    }
}
