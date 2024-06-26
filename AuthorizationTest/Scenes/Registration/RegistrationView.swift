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
        ZStack {
            Color.universalWhite
                .ignoresSafeArea()
            
            GeometryReader { _ in
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
                                viewModel.createNewAccount()
                            }
                        
                        GoogleSignInButton {
                            isFocused.toggle()
                            viewModel.signInWithGoogle()
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
            }
            .padding()
            .padding(.top)
            
            if viewModel.isLoading {
                LoaderView()
            }
        }
        .navigationBarBackButtonHidden()
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
        .alert(viewModel.error.errorDescription, isPresented: $viewModel.showAlert) {}
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    RegistrationView(
        viewModel: RegistrationViewModel(router: MainRouter(),
                                         authorizationService: AuthorizationService()))
    .environmentObject(MainRouter())
}
