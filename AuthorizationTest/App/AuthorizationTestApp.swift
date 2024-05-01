import SwiftUI

@main
struct AuthorizationTestApp: App {
    
    // MARK: - Classes:
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let registrationViewModel = RegistrationViewModel()
    
    var body: some Scene {
        WindowGroup {
            RegistrationView(viewModel: registrationViewModel)
        }
    }
}
