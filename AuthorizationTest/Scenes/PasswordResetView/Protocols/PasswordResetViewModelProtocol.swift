import Foundation

protocol PasswordResetViewModelProtocol: ObservableObject {
    var email: String { get set }
    var isUnlocked: Bool { get }
    var isMessageSent: Bool { get }
    var showAlert: Bool { get set }
    var error: AuthorizationError { get }
    
    func resetPassword()
}
