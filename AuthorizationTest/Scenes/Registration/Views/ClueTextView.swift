import SwiftUI

enum ClueTextViewState: Equatable {
    case username
    case passwordLength
    case uppercasedLetter
    case confirmedPassword
    
    var promptText: String {
        return switch self {
        case .username:
            Strings.Registration.Prompt.username
        case .passwordLength:
            Strings.Registration.Prompt.passwordLength
        case .uppercasedLetter:
            Strings.Registration.Prompt.uppercasedLetter
        case .confirmedPassword:
            Strings.Registration.Prompt.confirmedPassword
        }
    }
}

struct ClueTextView: View {
    
    // MARK: - Constants and Variables:
    var state: ClueTextViewState
    
    // MARK: - Bindings:
    var isValid: Bool
    
    var body: some View {
        HStack {
            if state == .username {
                Rectangle()
                    .stroke(.blue, lineWidth: UIConstants.ClueTextView.strokeLineWidth)
                    .frame(width: UIConstants.ClueTextView.imageSide,
                           height: UIConstants.ClueTextView.imageSide)
                    .clipShape(RoundedRectangle(cornerRadius: UIConstants.ClueTextView.cornerRadius))
                    .overlay {
                        if isValid {
                            Image(systemName: Resources.Images.multiply)
                                .foregroundStyle(.blue)
                        }
                    }
            } else {
                Image(systemName: isValid ? Resources.Images.lockOpen : Resources.Images.lockClosed)                   
                    .frame(width: UIConstants.ClueTextView.imageSide,
                           height: UIConstants.ClueTextView.imageSide)
                    .foregroundStyle(.blue)
            }
            
            Text(state.promptText)
                .font(.regularMediumFont)
                .foregroundStyle(.gray)
                .strikethrough(isValid)
            
            Spacer()
        }
    }
}


#Preview {
    ClueTextView(state: .passwordLength, isValid: true)
}
