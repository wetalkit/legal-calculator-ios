
import UIKit

enum AlertType {
    case ok
    case okCancel
    case okRetry
    
    func secondActionTitle() -> String {
        switch self {
        case .ok:
            return "Ok"
        case .okCancel:
            return "Cancel"
        case .okRetry:
            return "Retry"
        }
    }
}

final class AlertHelper {
    
    //MARK: Internal Methods
    class func showAlertWithType(_ type: AlertType, title: String, message: String, presenter: UIViewController, block: (() -> Void)? = nil) {
        let handler = { (action: UIAlertAction) -> Void in
            block?()
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: type !=  .okRetry ? handler : nil)
        alertController.addAction(okAction)
        if type != .ok {
            let secondAction = UIAlertAction(title: type.secondActionTitle(), style: .default, handler: type ==  .okRetry ? handler : nil)
            alertController.addAction(secondAction)
        }
        presenter.present(alertController, animated: true, completion: nil)
    }
    
    class func showCustomAlert(_ title: String, message: String, presenter: UIViewController, buttons: [String], actions: [(() -> Void)]) {
        assert(buttons.count == actions.count, "buttons count should be equal with actions count")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for i in 0..<buttons.count {
            let handler = { (action: UIAlertAction) -> Void in
                actions[i]()
            }
            let action = UIAlertAction(title: buttons[i], style: .default, handler: handler)
            alertController.addAction(action)
        }
        
        presenter.present(alertController, animated: true, completion: nil)
    }
}
