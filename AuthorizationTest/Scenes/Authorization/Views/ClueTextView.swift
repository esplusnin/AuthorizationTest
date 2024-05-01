import SwiftUI

enum ClueTextViewState: Equatable {
    case username
    case passwordLength
    case uppercasedLetter
    case repeatedPassword
    
    var promptText: String {
        return switch self {
        case .username:
            "Необходимо как минимум 4 символа"
        case .passwordLength:
            "Необходимо как минимум 8 символов"
        case .uppercasedLetter:
            "Один из символов должен быть заглавным"
        case .repeatedPassword:
            "Пароли должны совпадать"
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
                    .stroke(.blue, lineWidth: 2)
                    .frame(width: 15, height: 15)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .overlay {
                        if isValid {
                            Image(systemName: "multiply")
                                .foregroundStyle(.blue)
                        }
                    }
            } else {
                Image(systemName: isValid ? "lock.open" : "lock")                    .frame(width: 15, height: 15)
                    .foregroundStyle(.blue)
            }
            
            Text(state.promptText)
                .font(.system(size: 14))
                .foregroundStyle(.gray)
                .strikethrough(isValid)
            
            Spacer()
        }
    }
}


#Preview {
    ClueTextView(state: .passwordLength, isValid: true)
}
