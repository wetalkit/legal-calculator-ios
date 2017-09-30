//
//  UIView+Extensions.swift
//  BilPlus
//
//  Created by Dejan Atanasov on 15/08/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

extension UIView {
    
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set (radius) {
            layer.cornerRadius = radius
            layer.masksToBounds = true
        } get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        set (color) {
            layer.borderWidth = 1
            layer.borderColor = color.cgColor
        } get {
            return UIColor(cgColor: layer.borderColor!)
        }
    }
    
    
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        
    }
    
    //MARK: - Frame
    func height() -> CGFloat{
        return frame.size.height
    }
    func width() -> CGFloat{
        return frame.size.width
    }
    func x() -> CGFloat{
        return frame.origin.x
    }
    func y() -> CGFloat{
        return frame.origin.y
    }

    //MARK: Animations
    func popIn(){
        self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (success) in
            self.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
        }
    }
    
    func popOut(){
        self.layer.backgroundColor = UIColor.clear.cgColor
        UIView.animate(withDuration: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y:0.1)
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    func fadeIn(){
        self.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        })
    }
    
    func fadeOut(){
        self.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }){ (finished) in
            self.removeFromSuperview()
        }
    }
    
}
