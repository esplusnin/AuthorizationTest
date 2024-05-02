import SwiftUI
import GoogleSignIn

struct RegistrationView<ViewModel>: View where ViewModel: RegistrationViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - UI:
    var body: some View {
        ZStack {
            Color.universalWhite
                .ignoresSafeArea()
            
            VStack(spacing: UIConstants.RegistrationView.largeVStackSpacing) {
                Text(Strings.Registration.title)
                    .font(.extraLargeBoldFont)
                    .foregroundStyle(.universalBlue)
                
                VStack(spacing: UIConstants.RegistrationView.smallVStackSpacing) {
                    InputTextField(inputText: $viewModel.email, state: .username)
                    ClueTextView(state: .username, isValid: viewModel.isEmailValidated)
                }
                
                VStack(spacing: UIConstants.RegistrationView.smallVStackSpacing) {
                    InputTextField(inputText: $viewModel.password, state: .password)
                    ClueTextView(state: .passwordLength,
                                 isValid: viewModel.isPasswordLengthValidated)
                    ClueTextView(state: .uppercasedLetter,
                                 isValid: viewModel.isPasswordCapitalLetterValidated)
                }
                
                VStack(spacing: UIConstants.RegistrationView.smallVStackSpacing) {
                    InputTextField(inputText: $viewModel.confirmedPassword, state: .confirmedPassword)
                    ClueTextView(state: .confirmedPassword,
                                 isValid: viewModel.isPasswordConfirmed)
                }
                
                Spacer()
                
                VStack(spacing: UIConstants.RegistrationView.mediumVStackSpacing) {
                    BaseButtonView(isUnlocked: viewModel.isEmailValidated &&
                                   viewModel.isPasswordConfirmed && viewModel.isPasswordCapitalLetterValidated) {
                        createNewAccount()
                    }
                    
                    GoogleSignInButton {
                        signInWithGoogle()
                    }
                    
                    HStack {
                        Text(Strings.Registration.hasAccount)
                            .foregroundStyle(.universalBlack)
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
    
    // MARK: - Private Methods:
    private func createNewAccount() {
        Task {
            await viewModel.createNewAccount()
        }
    }
    
    private func signInWithGoogle() {
        Task {
            await viewModel.signInWithGoogle()
        }
    }
}

#Preview {
    RegistrationView(viewModel: RegistrationViewModel(authorizationService: AuthorizationService()))
}
