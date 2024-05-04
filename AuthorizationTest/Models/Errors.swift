import Foundation

enum AuthorizationError: Error {
    case signInByGoogleError
    case signInError
    case createNewAccountError
    case emailVerificationError
    case resetPasswordError
    case defaultError
    
    var errorDescription: String {
        return switch self {
        case .signInByGoogleError:
            Strings.ErrorDescription.signInByGoogleError
        case .signInError:
            Strings.ErrorDescription.signInError
        case .createNewAccountError:
            Strings.ErrorDescription.createNewAccountError
        case .emailVerificationError:
            Strings.ErrorDescription.emailVerificationError
        case .resetPasswordError:
            Strings.ErrorDescription.resetPasswordError
        default:
            Strings.ErrorDescription.defalt
        }
    }
}
