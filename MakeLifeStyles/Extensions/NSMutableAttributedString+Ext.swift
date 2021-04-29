import UIKit

extension NSMutableAttributedString {
    
    func bold(_ value: String, _ fontSize: CGFloat) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: Fonts.avenirNextBold, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize),
        ]

        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    
    func normal(_ value: String, _ fontSize: CGFloat) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: Fonts.avenirNextRegular, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
        ]

        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
