import Foundation

protocol AuthorizationServiceProtocol: AnyObject {
    func createNewAccount(with email: String, and password: String) async throws -> UserDTO
    func signInWithGoogle() async throws -> Bool
}
