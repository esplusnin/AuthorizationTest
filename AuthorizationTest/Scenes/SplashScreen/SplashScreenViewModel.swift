import Foundation

final class SplashScreenViewModel: SplashScreenViewModelProtocol {
    
    // MARK: - Dependencies:
    weak var router: MainRouter?
    
    private(set) var keyChainStorage: KeyChainStorage?
    
    // MARK: - Publishers:
    @Published var isUserAuthorized: Bool?
    
    // MARK: - Lifecycle:
    init(router: MainRouter) {
        self.router = router
    }
    
    // MARK: - Private Methods:
    @MainActor func checkIsUserAuthorized() {
        keyChainStorage = KeyChainStorage()
        
        if let _ = keyChainStorage?.getUserInfo() {
            router?.goTo(.imageEditor)
        } else {
            router?.goTo(.registration)
        }
    }
}
