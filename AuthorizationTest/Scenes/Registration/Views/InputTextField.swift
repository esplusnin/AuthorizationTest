import SwiftUI

enum TextFieldState {
    case username
    case password
    case confirmedPassword
    
    var promptText: String {
        return switch self {
        case .username:
            Strings.Registration.username
        case .password:
            Strings.Registration.password
        case .confirmedPassword:
            Strings.Registration.confirmPassword
        }
    }
}

struct InputTextField: View {
    
    // MARK: - Bindings:
    @Binding var inputText: String
    
    // MARK: - Constants and Variables:
    var state: TextFieldState
    
    // MARK: - UI:
    var body: some View {
        if state == .username {
            TextField("Enter info",
                      text: $inputText,
                      prompt: Text(state.promptText))
        } else {
            SecureField("Enter info",
                        text: $inputText,
                        prompt: Text(state.promptText))
        }
        
        Divider()
    }
}

#Preview {
    InputTextField(inputText: .constant(""), state: .password)
}
