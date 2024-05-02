import Foundation

protocol AuthorizationViewModelProtocol: ObservableObject {
    var authorizationService: AuthorizationServiceProtocol { get }
    var email: String { get set }
    var password: String { get set }
    var isReadyToSignIn: Bool { get }
    var isLoading: Bool { get }
    
    func signIn()
}
