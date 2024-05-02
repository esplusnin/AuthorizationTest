import Combine
import Foundation

final class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    // MARK: - Dependencies:
    weak var router: MainRouter?
    
    private(set) var authorizationService: AuthorizationServiceProtocol
    
    // MARK: - Publishers:
    @Published var email = ""
    @Published var password = ""
    @Published var isReadyToSignIn = false
    @Published var isLoading = false
    
    // MARK: - Constants and Variables:
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Lifecycle:
    init(router: MainRouter, authorizationService: AuthorizationServiceProtocol) {
        self.router = router
        self.authorizationService = authorizationService
        setupEmailAndPasswordsObserver()
    }
    
    // MARK: - Public Methods:
    func signIn() {
        isLoading.toggle()

        Task {
            do {
                let _ = try await authorizationService.signIn(with: email, and: password)
                await router?.goTo(.imageEditor)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        isLoading.toggle()
    }
    
    // MARK: - Private Methods:
    private func setupEmailAndPasswordsObserver() {
        Publishers.CombineLatest($email, $password)
            .receive(on: RunLoop.main)
            .map { email, password in
                email != "" && password != ""
            }
            .assign(to: \.isReadyToSignIn, on: self)
            .store(in: &cancellable)
    }
}
