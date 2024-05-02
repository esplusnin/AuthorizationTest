import Foundation

protocol AuthorizationViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var isReadyToSignIn: Bool { get }
    var isLoading: Bool { get }
    
    func signIn() async
}
