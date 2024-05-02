import Foundation

protocol AuthorizationServiceProtocol: AnyObject {
    func createNewAccount(with email: String, and password: String) async throws -> UserDTO
    func signIn(with email: String, and password: String) async throws -> UserDTO
    func signInWithGoogle() async throws -> Bool
    func resetPassword(with email: String) async throws
}
