import Foundation

class DataStore {
    
    static let shared  = DataStore()
    
    
    private init(){}
    
    
    func setUserStatus() {
        UserDefaults.standard.setValue(true, forKey: "user-status")
    }
    
     
    func getUserStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "user-status")
    }
}

