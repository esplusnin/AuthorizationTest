import SwiftUI
import GoogleSignIn

struct RegistrationView<ViewModel>: View where ViewModel: RegistrationViewModelProtocol {
    
    // MARK: - Dependencies:
    @EnvironmentObject var router: MainRouter
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - UI:
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            ZStack {
                Color.universalWhite
                    .ignoresSafeArea()
                
                VStack(spacing: UIConstants.RegistrationView.largeVStackSpacing) {
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
                        BaseButtonView(
                            title: Strings.Registration.createAccount,
                            isUnlocked: viewModel.isEmailValidated &&
                            viewModel.isPasswordConfirmed &&
                            viewModel.isPasswordCapitalLetterValidated) {
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
                                router.goTo(.authorization)
                            } label: {
                                Text(Strings.Registration.singIn)
                                    .bold()
                            }
                        }
                    }
                }
                .padding(.bottom, UIConstants.RegistrationView.bottomPadding)
                .blur(radius: viewModel.isLoading ? 20 : 0)
                
                if viewModel.isLoading {
                    LoaderView()
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Strings.Registration.title)
                        .font(.extraLargeBoldFont)
                        .foregroundStyle(.universalBlue)
                }
            }
            .navigationDestination(for: MainRouter.RouterDestination.self) { destination in
                switch destination {
                case .authorization:
                    let authorizationService = viewModel.authorizationService
                    let viewModel = AuthorizationViewModel(router: router,
                                                           authorizationService: authorizationService)
                    AuthorizationView(viewModel: viewModel)
                case .imageEditor:
                    ImageEditorView()
                }
            }
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
    RegistrationView(
        viewModel: RegistrationViewModel(authorizationService: AuthorizationService()))
}
