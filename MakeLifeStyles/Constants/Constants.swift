import UIKit

// MARK: Asserts
struct Asserts {
    // Tab Bar
    static let add = UIImage(named: "add")!
    static let home = UIImage(named: "home")!
    static let star = UIImage(named: "star")!
    
    // Screens
    static let personOnBicycle = UIImage(named: "person_on_bicycle")!
    static let circle = UIImage(named: "circle")!
    static let personOnScooter = UIImage(named: "person_on_scooter")!
    
    // Common
    static let placeHolder = UIImage(named: "placeholder")!
}


// MARK: Strings
struct Strings {
    // Get Started Screen
    static let areYouReady = "Are you ready?\nNow we gonna build your\n morning routine!"
    static let itsTimeToBuild = "It's time to build\n"
    static let someHabits = "some habits!"
    
    // User Details Screen
    static let oneDot = "1."
    static let nameQuestion = "Okay firstly,\n how can I call you?"
    static let enterYourName = "Enter your name"
    
    // Make Habbits Screen
    static let create = "Create"
    static let nameYourHabbit = "Name your habit:"
    static let buildOrQuitHabbit = "Build or Quit this habit?"
    static let howManyDays = "How many days you have been doing this?"
    static let oneDay = "1 Day"
    static let setYourGoal = "Set your goal:"
    static let one = "1"
    static let moreTimesPerDay = "Or more times per day"
    static let days = "Days"
    
    // Home Screen
    static let home = "Home"
    
    // Habit Details Screen
    static let habit = "Habit"
    static let habitType = "Habit Type"
    static let numberOfDays = "Number of Days"
    static let goal = "Goal"
    
    // Life Style Screen
    static let lifeStyles = "Life Styles"
    
    // Common
    static let successful = "Successful"
    static let failed = "Failed"
    static let congradulations = "Congradulations"
    static let youHaveNewLifeStyleNow = "You have a new lifestyle now 🏆🏆🏆"
    static let empty = ""
    static let somethingWentWrong = "Something went wront"
    static let habitSavedSuccessfully = "Habit Saved Successfully"
    static let habitUpdatedSuccessfully = "Habit Updated Successfully"
    static let unableToCompleteRequest = "Unable to complete request"

    // Buttons
    static let ok = "Ok"
    static let back = "Back"
    static let continueString = "Continue"
    static let build = "Build"
    static let quit = "Quit"
    static let save = "Save"
    static let update = "Update"
}


// MARK: Globle Constants
struct GlobalConstants {
    static let charactorLimit = 15
    static let lifeStyleDays = 66
}


// MARK: Global Dimensions
struct GlobalDimensions {
    static let height: CGFloat = 50
    static let cornerRadius: CGFloat = height / 2
    static let borderWidth: CGFloat = 0.5
}


// MARK: Fonts
struct Fonts {
    static let avenirNext = "Avenir Next"
}
