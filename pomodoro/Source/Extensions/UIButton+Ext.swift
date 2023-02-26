import UIKit

extension UIButton {
    convenience init(image: String,
                     imageColor: UIColor,
                     backgroundColor: UIColor,
                     action: Selector,
                     target: Any?) {
        self.init()
        self.setImage(UIImage(systemName: image), for: .normal)
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        self.tintColor = imageColor
        self.backgroundColor = backgroundColor
        self.addTarget(target, action: action, for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

