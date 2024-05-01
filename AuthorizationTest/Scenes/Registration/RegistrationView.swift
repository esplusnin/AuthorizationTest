import SwiftUI
import GoogleSignIn

struct RegistrationView<ViewModel>: View where ViewModel: RegistrationViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - UI:
    var body: some View {
        ZStack {
            LinearGradient.backgroundGradient
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Регистрация")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                VStack(spacing: 10) {
                    InputTextField(inputText: $viewModel.username, state: .username)
                    ClueTextView(state: .username, isValid: viewModel.isLoginValidated)
                }
                
                VStack(spacing: 10) {
                    InputTextField(inputText: $viewModel.password, state: .password)
                    ClueTextView(state: .passwordLength,
                                 isValid: viewModel.isPasswordLengthValidated)
                    ClueTextView(state: .uppercasedLetter,
                                 isValid: viewModel.isPasswordCapitalLetterValidated)
                }
                
                VStack(spacing: 10) {
                    InputTextField(inputText: $viewModel.repeatedPassword, state: .repeatedPassword)
                    ClueTextView(state: .repeatedPassword,
                                 isValid: viewModel.isPasswordRepeated)
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    BaseButtonView(action: {})
                    GoogleSignInButton { viewModel.signInWithGoogle() }
                    
                    HStack {
                        Text("Уже зарегистрированы?")
                        
                        Button {
                            
                        } label: {
                            Text("Войти")
                                .bold()
                        }
                    }
                }
                .padding(.bottom, 100)
            }
            .padding()
        }
    }
}

#Preview {
    RegistrationView(viewModel: RegistrationViewModel())
}
