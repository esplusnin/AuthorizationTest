import Combine
import Foundation

final class RegistrationViewModel: RegistrationViewModelProtocol {
    
    // MARK: - Dependencies:
    weak var router: MainRouter?
    
    private(set) var keyChainStorage = KeyChainStorage()
    private(set) var authorizationService: AuthorizationServiceProtocol
    
    // MARK: - Publishers:
    @Published var email = ""
    @Published var password = ""
    @Published var confirmedPassword = ""
    @Published var isEmailValidated = false
    @Published var isPasswordLengthValidated = false
    @Published var isPasswordCapitalLetterValidated = false
    @Published var isPasswordConfirmed = false
    @Published var isReadyToCreateAccount = false
    @Published var isLoading = false
    
    // MARK: - Constatns and Variables:
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Lifecycle:
    init(authorizationService: AuthorizationServiceProtocol) {
        self.authorizationService = authorizationService
        setupEmailValidationObserver()
        setupPasswordLengthValidationObserver()
        setupCorrectedValidationObserver()
    }
    
    // MARK: - Public Methods:
    func createNewAccount() async {
        await changeIsLoadingState()

        do {
            let _ = try await authorizationService.createNewAccount(with: email, and: password)
            await router?.goTo(.imageEditor)
        } catch {
            print(error.localizedDescription)
        }
        
        await changeIsLoadingState()
    }
    
    func signInWithGoogle() async {
        await changeIsLoadingState()

        do {
            let userInfo = try await authorizationService.signInWithGoogle()
            saveNew(userInfo)
            await router?.goTo(.imageEditor)
        } catch {
            print(error.localizedDescription)
        }
        
        await changeIsLoadingState()
    }
    
    // MARK: - Private Methods:
    @MainActor
    private func changeIsLoadingState() {
        isLoading.toggle()
    }
    
    private func saveNew(_ userInfo: UserDTO) {
        Task {
            await keyChainStorage.setNewValue(with: userInfo)
        }
    }
    
    private func setupEmailValidationObserver() {
        $email
            .receive(on: RunLoop.main)
            .map { email in
                self.isValid(email)
            }
            .assign(to: \.isEmailValidated, on: self)
            .store(in: &cancellable)
    }
    
    private func setupPasswordLengthValidationObserver() {
        $password
            .receive(on: RunLoop.main)
            .map { password in
                password.count >= 8
            }
            .assign(to: \.isPasswordLengthValidated, on: self)
            .store(in: &cancellable)
    }
    
    private func setupCorrectedValidationObserver() {
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetterValidated, on: self)
            .store(in: &cancellable)
        
        Publishers.CombineLatest($password, $confirmedPassword)
            .receive(on: RunLoop.main)
            .map { password, confirmedPassword in
                password != "" && password == confirmedPassword
            }
            .assign(to: \.isPasswordConfirmed, on: self)
            .store(in: &cancellable)
    }
    
    private func isValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
