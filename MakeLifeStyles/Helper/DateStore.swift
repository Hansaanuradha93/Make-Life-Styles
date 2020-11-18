import Foundation

class DataStore {
    
    static let shared  = DataStore()
    
    
    private init(){}
    
    
    func setUserStatus(isNewUser: Bool) {
        UserDefaults.standard.setValue(isNewUser, forKey: "user-status")
    }
    
     
    func getUserStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "user-status")
    }
}

