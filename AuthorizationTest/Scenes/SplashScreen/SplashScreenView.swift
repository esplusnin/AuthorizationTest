import SwiftUI

struct SplashScreenView<ViewModel>: View where ViewModel: SplashScreenViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var router: MainRouter
    
    @StateObject var authorizationService = AuthorizationService()
    
    // MARK: - UI:
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            ZStack {
                Color.universalWhite
                    .ignoresSafeArea()
                
                Text(Strings.SplashScreen.title)
                    .font(.extraLargeBoldFont)
            }
            .onAppear {
                viewModel.checkIsUserAuthorized()
            }
            .navigationDestination(for: MainRouter.RouterDestination.self) { destination in
                switch destination {
                case .registration:
                    let viewModel = RegistrationViewModel(
                        router: router,
                        authorizationService: authorizationService)
                    RegistrationView(viewModel: viewModel)
                case .authorization:
                    if let keyChainStorage = viewModel.keyChainStorage {
                        let viewModel = AuthorizationViewModel(
                            router: router,
                            keyChainStorage: keyChainStorage,
                            authorizationService: authorizationService)
                        AuthorizationView(viewModel: viewModel)
                    }
                case .imageEditor:
                    ImageEditorView(viewModel: ImageEditorViewModel())
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    SplashScreenView(viewModel: SplashScreenViewModel(router: MainRouter()), router: MainRouter())
}
