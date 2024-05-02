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

final class AuthorizationService {
    
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
           let email = user.email {
            let userDTO = UserDTO(id: user.uid, email: email)
            try await sendEmailVerification()
            
            return userDTO
        } else {
            throw AuthorizationError.createNewAccountError
        }
    }

    func signIn(with email: String, and password: String) async throws -> UserDTO {
        let result = try? await Auth.auth().signIn(withEmail: email, password: password)
        
        if let user = result?.user,
           let email = user.email {
            let userDTO = UserDTO(id: user.uid, email: email)
            return userDTO
        } else {
            throw AuthorizationError.signInError
        }
    }
    
    func signInWithGoogle() async throws -> Bool {
        let signInResult = try await startGoogleSignInInteractive()
        
        guard let user = signInResult?.user,
              let idToken = user.idToken?.tokenString else { return false }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
        
        let authResult = try? await Auth.auth().signIn(with: credential)
        
        if let _ = authResult?.user {
            return true
        } else {
            return false
        }
    }
}
