import UIKit

enum AssertColor: String {
    case lightAsh = "light_ash"
    case darkestAsh = "darkest_ash"
    case greenishBlue = "greenish_blue"
    case lighestGreen = "lighest_green"
    case lightYellow = "light_yellow"
    case pinkishRed = "pinkish_red"
    case teal = "teal"
    case lightBlack = "light_black"
}


extension UIColor {
    static func appColor(color: AssertColor) -> UIColor {
        return UIColor(named: color.rawValue)!
    }
}
