import Foundation

struct Habit {
    let icon: String
    let name: String
    var days: Int

    var isHabit: Bool {
        return days >= 22
    }
    
    var isLifeStyle: Bool {
        return isHabit && days >= 66
    }
}
