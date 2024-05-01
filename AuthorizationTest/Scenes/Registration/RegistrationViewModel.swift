import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

final class RegistrationViewModel: RegistrationViewModelProtocol {
    
    // MARK: - Publishers:
    @Published var username = ""
    @Published var password = ""
    @Published var repeatedPassword = ""
    @Published var isLoginValidated = false
    @Published var isPasswordLengthValidated = false
    @Published var isPasswordCapitalLetterValidated = false
    @Published var isPasswordRepeated = false
    
    // MARK: - Public Methods:
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewController) { [weak self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error {
                    
                }
                
                guard let user = result?.user else { return }
            }
        }
    }
}
