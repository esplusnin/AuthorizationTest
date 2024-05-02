import Foundation

protocol PasswordResetViewModelProtocol: ObservableObject {
    var email: String { get set }
    var isUnlocked: Bool { get }
    var isMessageSent: Bool { get }
    func resetPassword()
}
