import SwiftUI

@MainActor
final class MainRouter: ObservableObject {
    
    // MARK: - Constatns and Variables:
    enum RouterDestination {
        case registration
        case authorization
        case imageEditor
    }
    
    // MARK: - Publishers:
    @Published var navigationPath = NavigationPath()
    
    // MARK: - Public Methods:
    func goTo(_ destination: RouterDestination) {
        navigationPath.append(destination)
    }
    func goBack() {
        navigationPath.removeLast()
    }
    
    func goToRoot() {
        navigationPath.removeLast(navigationPath.count - 1)
    }
}
