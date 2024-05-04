import Combine
import Foundation

final class PasswordResetViewModel: PasswordResetViewModelProtocol {
    
    // MARK: - Dependencies:
    private let authorizationService: AuthorizationServiceProtocol
    
    // MARK: - Publishers:
    @Published var email = ""
    @Published var isUnlocked = false
    @Published var isMessageSent = false
    @Published var showAlert = false
    
    // MARK: - Constants and Variables:
    private(set) var error: AuthorizationError = .defaultError
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Lifecycle:
    init(authorizationService: AuthorizationServiceProtocol) {
        self.authorizationService = authorizationService
        setupEmailObserver()
    }
    
    // MARK: - Public Methods:
    func resetPassword() {
        Task {
            do {
                try await authorizationService.resetPassword(with: email)
            } catch {
                switch error as? AuthorizationError {
                case .resetPasswordError:
                    self.error = .resetPasswordError
                default:
                    self.error = .defaultError
                }
                
                showAlert.toggle()
            }
        }
        
        isMessageSent.toggle()
    }
    
    // MARK: - Private Methods:
    private func setupEmailObserver() {
        $email
            .receive(on: RunLoop.main)
            .map { email in
                self.isValid(email)
            }
            .assign(to: \.isUnlocked, on: self)
            .store(in: &cancellable)
    }
    
    private func isValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
