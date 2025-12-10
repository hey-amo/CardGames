import SwiftUI

@Observable
final class NavigationStack {
    var path: [Route] = []
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func popToRoute(_ route: Route) {
        while !path.isEmpty && path.last != route {
            path.removeLast()
        }
    }
}