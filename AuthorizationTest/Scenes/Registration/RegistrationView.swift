import SwiftUI
import GoogleSignIn

struct RegistrationView<ViewModel>: View where ViewModel: RegistrationViewModelProtocol {
    
    // MARK: - Dependencies:
    @EnvironmentObject var router: MainRouter
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Bindings:
    @FocusState var isFocused: Bool
    
    // MARK: - UI:
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            GeometryReader { _ in
                ZStack {
                    Color.universalWhite
                        .ignoresSafeArea()
                    
                    VStack(spacing: UIConstants.RegistrationView.largeVStackSpacing) {
                        VStack(spacing: UIConstants.RegistrationView.smallVStackSpacing) {
                            InputTextField(inputText: $viewModel.email, 
                                           state: .username)
                                .focused($isFocused)
                            
                            ClueTextView(state: .username, isValid: viewModel.isEmailValidated)
                        }
                        
                        VStack(spacing: UIConstants.RegistrationView.smallVStackSpacing) {
                            InputTextField(inputText: $viewModel.password, 
                                           state: .password)
                                .focused($isFocused)
                            
                            ClueTextView(state: .passwordLength,
                                         isValid: viewModel.isPasswordLengthValidated)
                            ClueTextView(state: .uppercasedLetter,
                                         isValid: viewModel.isPasswordCapitalLetterValidated)
                        }
                        
                        VStack(spacing: UIConstants.RegistrationView.smallVStackSpacing) {
                            InputTextField(inputText: $viewModel.confirmedPassword, 
                                           state: .confirmedPassword)
                            .focused($isFocused)

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
                                    isFocused.toggle()
                                    createNewAccount()
                                }
                            
                            GoogleSignInButton {
                                isFocused.toggle()
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
                    .blur(radius: viewModel.isLoading ?
                          UIConstants.RegistrationView.blurValue : 0)
                    
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
                .onTapGesture {
                    isFocused.toggle()
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
            .ignoresSafeArea(.keyboard)
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
    .environmentObject(MainRouter())
}
