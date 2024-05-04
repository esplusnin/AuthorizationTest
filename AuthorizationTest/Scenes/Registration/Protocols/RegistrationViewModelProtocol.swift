import Foundation

protocol RegistrationViewModelProtocol: ObservableObject {
    var authorizationService: AuthorizationServiceProtocol { get }
    var email: String { get  set }
    var password: String { get  set }
    var confirmedPassword: String { get set }
    var isEmailValidated: Bool{ get }
    var isPasswordLengthValidated: Bool { get }
    var isPasswordCapitalLetterValidated: Bool { get }
    var isPasswordConfirmed: Bool { get }
    var isLoading: Bool { get }
    var showAlert: Bool { get set }
    var error: AuthorizationError { get }
    
    func createNewAccount()
    func signInWithGoogle()
}
