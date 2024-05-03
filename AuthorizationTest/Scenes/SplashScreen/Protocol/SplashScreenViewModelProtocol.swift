import Foundation

protocol SplashScreenViewModelProtocol: ObservableObject {
    var keyChainStorage: KeyChainStorage? { get }
    func checkIsUserAuthorized()
}
