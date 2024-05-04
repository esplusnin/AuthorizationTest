import Foundation

protocol AuthorizationViewModelProtocol: ObservableObject {
    var authorizationService: AuthorizationServiceProtocol { get }
    var email: String { get set }
    var password: String { get set }
    var isReadyToSignIn: Bool { get }
    var isLoading: Bool { get }
    var showAlert: Bool { get set }
    var error: AuthorizationError { get }
    
    func signIn()
}
