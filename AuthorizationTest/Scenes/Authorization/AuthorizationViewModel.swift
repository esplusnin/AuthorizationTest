import Combine
import Foundation

final class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    // MARK: - Dependencies:
    weak var router: MainRouter?
    
    private var keyChainStorage: KeyChainStorage
    private(set) var authorizationService: AuthorizationServiceProtocol
    
    // MARK: - Publishers:
    @Published var email = ""
    @Published var password = ""
    @Published var isReadyToSignIn = false
    @Published var isLoading = false
    @Published var showAlert = false
    
    // MARK: - Constants and Variables:
    private var cancellable = Set<AnyCancellable>()
    private(set) var error: AuthorizationError = .defaultError
    
    // MARK: - Lifecycle:
    init(router: MainRouter, keyChainStorage: KeyChainStorage, authorizationService: AuthorizationServiceProtocol) {
        self.router = router
        self.keyChainStorage = keyChainStorage
        self.authorizationService = authorizationService
        setupEmailAndPasswordsObserver()
    }
    
    // MARK: - Public Methods:
    func signIn() {
        Task {
            await changeLoadingStatus()

            do {
                let userInfo = try await authorizationService.signIn(with: email, and: password)
                saveNew(userInfo)
                await router?.goTo(.imageEditor)
            } catch {
                switch error as? AuthorizationError {
                case .signInError:
                    self.error = .signInError
                default:
                    self.error = .defaultError
                }
                
                showAlert.toggle()
            }
            
            await changeLoadingStatus()
        }
    }
    
    // MARK: - Private Methods:
    @MainActor
    private func changeLoadingStatus() {
        isLoading.toggle()
    }
    
    private func saveNew(_ userInfo: UserDTO) {
        Task {
            await keyChainStorage.setNewValue(with: userInfo)
        }
    }
    
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
