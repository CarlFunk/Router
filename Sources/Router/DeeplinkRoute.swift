//
//  DeeplinkRoute.swift
//  Router
//
//  Created by Carl Funk on 3/9/22.
//  Copyright © 2022 Carl Funk. All rights reserved.
//

import Foundation

public protocol DeeplinkRoute: Route {
    var currentRouteIndex: Int { get set }
    
    /// All routes along a deeplink route
    var routes: [Route] { get set }
}

public extension DeeplinkRoute {
    var identifier: String {
        currentRoute?.identifier ?? "NONE"
    }
    
    var data: [String : Any] {
        currentRoute?.data ?? [:]
    }
    
    var currentRoute: Route? {
        if routes.indices.contains(currentRouteIndex) {
            return routes[currentRouteIndex]
        }
        
        return nil
    }
    
    var nextRoute: Route? {
        let nextIndex = currentRouteIndex + 1
        if routes.indices.contains(nextIndex) {
            return routes[nextIndex]
        }
        
        return nil
    }
    
    var canNavigateToNextRoute: Bool {
        if routes.isEmpty {
            return false
        }
        
        if (0..<routes.count).contains(currentRouteIndex) {
            return true
        }
        
        return false
    }
    
    mutating func moveToNextRoute() {
        currentRouteIndex += 1
    }
}
