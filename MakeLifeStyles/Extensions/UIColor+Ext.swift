import UIKit

enum AssertColor: String {
    case lightGray = "color_name"
}


extension UIColor {
    static func appColor(color: AssertColor) -> UIColor {
        return UIColor(named: color.rawValue)!
    }
}
