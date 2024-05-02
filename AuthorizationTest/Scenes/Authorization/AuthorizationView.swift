import SwiftUI

struct AuthorizationView<ViewModel>: View where ViewModel: AuthorizationViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Bindings:
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack {
            Color.universalWhite
                .ignoresSafeArea()
            
            VStack(spacing: UIConstants.AuthorizationView.vStackSpacing) {
                InputTextField(inputText: $viewModel.email, state: .username)
                InputTextField(inputText: $viewModel.password, state: .password)
                
                Spacer()
                
                BaseButtonView(title: Strings.Registration.singIn,
                               isUnlocked: viewModel.isReadyToSignIn) {
                    signIn()
                }
                
                HStack {
                    HStack {
                        Text("Забыли пароль?")
                            .foregroundStyle(.universalBlack)
                            .bold()
                        
                    Button {
                        isSheetPresented.toggle()
                    } label: {
                        Text("Восстановить")
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
        .sheet(isPresented: $isSheetPresented) {
            
        }
    }
    
    // MARK: - Private Methods:
    private func signIn() {
        Task {
            await viewModel.signIn()
        }
    }
}

#Preview {
    AuthorizationView(
        viewModel: AuthorizationViewModel(
            router: MainRouter(),
            authorizationService: AuthorizationService()))
}
