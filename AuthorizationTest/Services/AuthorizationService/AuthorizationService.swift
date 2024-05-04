import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

enum AuthorizationError: Error {
    case signInByGoogleError
    case signInError
    case createNewAccountError
    case emailVerificationError
    case resetPasswordError
}

final class AuthorizationService: ObservableObject {
    
    // MARK: - Private Methods:
    private func sendEmailVerification() async throws {
        do {
            try await Auth.auth().currentUser?.sendEmailVerification()
        } catch {
            throw AuthorizationError.emailVerificationError
        }
    }
    
    @MainActor
    private func startGoogleSignInInteractive() async throws -> GIDSignInResult? {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return nil }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewController, hint: nil)
        return signInResult
    }
}

// MARK: - AuthorizationServiceProtocol:
extension AuthorizationService: AuthorizationServiceProtocol {
    
    // MARK: - Public Methods:
    func createNewAccount(with email: String, and password: String) async throws -> UserDTO {
        let result = try? await Auth.auth().createUser(withEmail: email, password: password)
        
        if let user = result?.user,
           let email = user.email,
           let token = user.refreshToken {
            let userDTO = UserDTO(id: user.uid, email: email, token: token)
            try await sendEmailVerification()
            
            return userDTO
        } else {
            throw AuthorizationError.createNewAccountError
        }
    }

    func signIn(with email: String, and password: String) async throws -> UserDTO {
        let result = try? await Auth.auth().signIn(withEmail: email, password: password)
        
        if let user = result?.user,
           let email = user.email,
           let token = user.refreshToken {
            let userDTO = UserDTO(id: user.uid, email: email, token: token)
            return userDTO
        } else {
            throw AuthorizationError.signInError
        }
    }
    
    func signInWithGoogle() async throws -> UserDTO {
        let signInResult = try await startGoogleSignInInteractive()
        
        guard let user = signInResult?.user,
              let idToken = user.idToken?.tokenString else {
            throw AuthorizationError.signInByGoogleError
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
        
        let authResult = try? await Auth.auth().signIn(with: credential)
        
        if let user = authResult?.user,
           let email = user.email,
           let token = user.refreshToken {
            return UserDTO(id: user.uid, email: email, token: token)
        } else {
            throw AuthorizationError.signInByGoogleError
        }
    }
    
    func resetPassword(with email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            throw AuthorizationError.resetPasswordError
        }
    }
}
