import UIKit

public extension UIView {
    func constrainToFillContainer(_ container: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }

    func constrainToFillSuperview() {
        if let superview = self.superview {
            self.constrainToFillContainer(superview)
        }
    }
}
