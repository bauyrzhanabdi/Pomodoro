import UIKit

extension UILabel {
    convenience init(text: String,
                     allignment: NSTextAlignment,
                     color: UIColor,
                     fontSize: CGFloat,
                     fontWeight: CGFloat) {
        self.init()
        self.text = text
        self.textAlignment = allignment
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(fontWeight))
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
