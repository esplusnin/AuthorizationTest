import Foundation

protocol RegistrationViewModelProtocol: ObservableObject {
    var username: String { get  set }
    var password: String { get  set }
    var repeatedPassword: String { get set }
    var isLoginValidated: Bool{ get }
    var isPasswordLengthValidated: Bool { get }
    var isPasswordCapitalLetterValidated: Bool { get }
    var isPasswordRepeated: Bool { get }
    
    func signInWithGoogle()
}
