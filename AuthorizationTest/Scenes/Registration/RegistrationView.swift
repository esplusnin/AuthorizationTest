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
            
            VStack(spacing: UIConstants.RegistrationView.largeVStackSpacing) {
                Text(Strings.Registration.title)
                    .font(.extraLargeBoldFont)
                    .foregroundStyle(.white)
                
                VStack(spacing: UIConstants.RegistrationView.smallVStackSpacing) {
                    InputTextField(inputText: $viewModel.username, state: .username)
                    ClueTextView(state: .username, isValid: viewModel.isLoginValidated)
                }
                
                VStack(spacing: UIConstants.RegistrationView.smallVStackSpacing) {
                    InputTextField(inputText: $viewModel.password, state: .password)
                    ClueTextView(state: .passwordLength,
                                 isValid: viewModel.isPasswordLengthValidated)
                    ClueTextView(state: .uppercasedLetter,
                                 isValid: viewModel.isPasswordCapitalLetterValidated)
                }
                
                VStack(spacing: UIConstants.RegistrationView.smallVStackSpacing) {
                    InputTextField(inputText: $viewModel.repeatedPassword, state: .confirmedPassword)
                    ClueTextView(state: .confirmedPassword,
                                 isValid: viewModel.isPasswordRepeated)
                }
                
                Spacer()
                
                VStack(spacing: UIConstants.RegistrationView.mediumVStackSpacing) {
                    BaseButtonView(action: {})
                    GoogleSignInButton { viewModel.signInWithGoogle() }
                    
                    HStack {
                        Text(Strings.Registration.hasAccount)
                            .bold()
                        Button {
                            
                        } label: {
                            Text(Strings.Registration.singIn)
                                .bold()
                        }
                    }
                }
                .padding(.bottom, UIConstants.RegistrationView.bottomPadding)
            }
            .padding()
        }
    }
}

#Preview {
    RegistrationView(viewModel: RegistrationViewModel())
}
