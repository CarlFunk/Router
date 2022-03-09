//
//  RouteCoordinatorView.swift
//  Router
//
//  Created by Carl Funk on 3/9/22.
//  Copyright © 2022 Carl Funk. All rights reserved.
//

import SwiftUI

/// SwiftUI view that handles routing / navigation when observing a route coordinator
public struct RouteCoordinatorView<RouteCoordinator: ObservableRouteCoordinator>: View {
    @ObservedObject private var routeCoordinator: RouteCoordinator
    
    public init(routeCoordinator: RouteCoordinator) {
        self.routeCoordinator = routeCoordinator
    }
    
    public var body: some View {
        NavigationLink(
            isActive: $routeCoordinator.isActive,
            destination: routeCoordinator.nextRouteView,
            label: { EmptyView() })
    }
}
