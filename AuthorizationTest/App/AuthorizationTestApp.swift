import SwiftUI

@main
struct AuthorizationTestApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RegistrationView()
        }
    }
}
