import Foundation

protocol PasswordResetViewModelProtocol: ObservableObject {
    var isMessageSent: Bool { get }
    func resetPassword() async
}
