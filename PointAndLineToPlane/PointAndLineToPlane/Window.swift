import UIKit
import Foundation


extension UIViewController{
  func changeRootViewController(_ viewControllerToPresent: UIViewController, _ option: UIView.AnimationOptions) {
    if let window = UIApplication.shared.windows.first {
      window.rootViewController = viewControllerToPresent
      UIView.transition(with: window, duration: 0.5, options: option, animations: nil)
    } else {
      viewControllerToPresent.modalPresentationStyle = .overFullScreen
      self.present(viewControllerToPresent, animated: true, completion: nil)
    }
  }
}
