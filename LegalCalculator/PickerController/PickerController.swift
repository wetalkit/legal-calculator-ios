
import Foundation
import UIKit

private let animationDuration: TimeInterval = 0.25

class PickerController: UIViewController {
    
    //MARK: Internal Properties
    var showedView: UIView!
    var actionBlock: (() -> Void)?
    var pickerTitle = "" {
        didSet {
            titleLabel.text = pickerTitle
        }
    }
    
    //MARK: Private Properties
    @IBOutlet fileprivate weak var actionButton: UIButton!
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var pickerBottomConstraint: NSLayoutConstraint!
    fileprivate var animationInProgress = false
    
    //MARK: Internal Methods
    func showModally() {
        let keyWindow = UIApplication.shared.keyWindow
        guard let rootVC = keyWindow?.rootViewController else {
            return
        }
        keyWindow!.endEditing(true)
        
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = .overCurrentContext
        rootVC.present(self, animated: false, completion: nil)
    }
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showedView.layoutIfNeeded()
        showContainer(true, completion: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

private extension PickerController {
    
    func setupUI() {
        showedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        showedView.frame = containerView.bounds
        containerView.addSubview(showedView)
        
        actionButton.setTitleColor(UIColor.white, for: .normal)
       
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        
        pickerBottomConstraint.constant = -containerView.frame.height - actionButton.frame.height
    }
    
    func showContainer(_ show: Bool, completion: (() -> Void)?) {
        if animationInProgress {
            return
        }
        
        animationInProgress = true
        let dy = containerView.frame.height + actionButton.frame.height
        
        UIView.animate(withDuration: animationDuration, animations: { [weak self] () -> Void in
            self?.pickerBottomConstraint.constant = show ? 0 : -dy
            self?.view.layoutIfNeeded()
            }, completion: { [weak self] (Bool) -> Void in
                self?.animationInProgress = false
                completion?()
            }) 
    }
    
    //MARK: Actions
    @objc func closeAction() {
        showContainer(false) { [weak self] () -> Void in
            self?.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func actionButtonPressed() {
        showContainer(false) { [weak self] () -> Void in
            self?.actionBlock?()
            self?.dismiss(animated: false, completion: nil)
        }
    }
}
