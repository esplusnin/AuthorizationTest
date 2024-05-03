import SwiftUI

@main
struct AuthorizationTestApp: App {
    
    // MARK: - Classes:
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let mainRouter = MainRouter()
        
    var body: some Scene {
        WindowGroup {
            SplashScreenView(viewModel: SplashScreenViewModel(router: mainRouter), router: mainRouter)
        }
    }
}
