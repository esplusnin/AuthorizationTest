import Foundation
import KeychainAccess

final class KeyChainStorage {
    
    // MARK: - Classes:
    private let keychain = Keychain()
    
    // MARK: - Constants and Variables:
    private var userData: Data? {
        get {
            try? keychain.getData(Resources.Identifiers.userInfo)
        }
        set {
            keychain[data: Resources.Identifiers.userInfo] = newValue
        }
    }
    
    // MARK: - Public Methods:
    func getUserInfo() -> UserDTO? {
        guard let userData else { return nil }
        let decoder = JSONDecoder()
        
        do {
            let userInfo = try decoder.decode(UserDTO.self, from: userData)
            return userInfo
        } catch {
            print(error.localizedDescription)
            return nil 
        }
    }
    
    func setNewValue(with userInfo: UserDTO) async {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(userInfo.self)
            self.userData = data
        } catch {
            print(error.localizedDescription)
        }
    }
}

