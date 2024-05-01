import SwiftUI

struct AuthorizationView: View {
    
    @State var username = ""
    @State var password = ""
    @State var repeatedPassword = ""
    
    @State var isLoginValidated = false
    @State var isPasswordLengthValidated = false
    @State var isPasswordCapitalLetterValidated = false
    @State var isPasswordRepeated = false
    
    var body: some View {
        ZStack {
            LinearGradient.backgroundGradient
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Регистрация")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                VStack(spacing: 10) {
                    InputTextField(inputText: $username, state: .username)
                    ClueTextView(state: .username, isValid: isLoginValidated)
                }
                
                VStack(spacing: 10) {
                    InputTextField(inputText: $password, state: .password)
                    ClueTextView(state: .passwordLength,
                                 isValid: isPasswordLengthValidated)
                    ClueTextView(state: .uppercasedLetter,
                                 isValid: isPasswordCapitalLetterValidated)
                }
                
                VStack(spacing: 10) {
                    InputTextField(inputText: $repeatedPassword, state: .repeatedPassword)
                    ClueTextView(state: .repeatedPassword,
                                 isValid: isPasswordRepeated)
                }
                
                BaseButtonView(action: {})
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    AuthorizationView()
}
