import Foundation

protocol RegistrationViewModelProtocol: ObservableObject {
    var email: String { get  set }
    var password: String { get  set }
    var confirmedPassword: String { get set }
    var isEmailValidated: Bool{ get }
    var isPasswordLengthValidated: Bool { get }
    var isPasswordCapitalLetterValidated: Bool { get }
    var isPasswordConfirmed: Bool { get }
    
    func createNewAccount() async
    func signInWithGoogle() async
}
