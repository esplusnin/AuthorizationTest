import SwiftUI

@main
struct AuthorizationTestApp: App {
    
    // MARK: - Dependencies:
    @StateObject var router = MainRouter()
    
    // MARK: - Classes:
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let registrationViewModel = RegistrationViewModel(authorizationService: AuthorizationService())
    
    var body: some Scene {
        WindowGroup {
            RegistrationView(viewModel: registrationViewModel)
                .environmentObject(router)
                .onAppear {
                    registrationViewModel.router = router
                }
        }
    }
}
