import SwiftUI

struct AuthorizationView<ViewModel>: View where ViewModel: AuthorizationViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Bindings:
    @FocusState var isFocused: Bool
    @State private var isSheetPresented = false
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color.universalWhite
                    .ignoresSafeArea()
                
                VStack(spacing: UIConstants.AuthorizationView.vStackSpacing) {
                    InputTextField(inputText: $viewModel.email, state: .username)
                        .focused($isFocused)

                    InputTextField(inputText: $viewModel.password, state: .password)
                        .focused($isFocused)
                    
                    Spacer()
                    
                    BaseButtonView(title: Strings.Registration.singIn,
                                   isUnlocked: viewModel.isReadyToSignIn) {
                        signIn()
                    }
                    
                    HStack {
                        HStack {
                            Text(Strings.Registration.forgetPassword)
                                .foregroundStyle(.universalBlack)
                                .bold()
                            
                            Button {
                                isSheetPresented.toggle()
                            } label: {
                                Text(Strings.Registration.resumePassword)
                                    .foregroundStyle(.universalBlue)
                                    .bold()
                            }
                        }
                    }
                }
                .padding()
                .padding(.bottom, UIConstants.RegistrationView.bottomPadding)
                .blur(radius: viewModel.isLoading ? 20 : 0)
                
                if viewModel.isLoading {
                    LoaderView()
                }
            }
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Strings.Authorization.title)
                        .font(.extraLargeBoldFont)
                        .foregroundStyle(.universalBlue)
                }
            }
            .onTapGesture {
                isFocused.toggle()
            }
            .sheet(isPresented: $isSheetPresented) {
                PasswordResetView(
                    viewModel: PasswordResetViewModel(
                        authorizationService: viewModel.authorizationService))
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    // MARK: - Private Methods:
    private func signIn() {
        viewModel.signIn()
    }
}

#Preview {
    AuthorizationView(
        viewModel: AuthorizationViewModel(
            router: MainRouter(),
            authorizationService: AuthorizationService()))
}
