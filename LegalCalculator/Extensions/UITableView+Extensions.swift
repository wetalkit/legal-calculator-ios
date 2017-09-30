//
//  UITableView+Extensions.swift
//  BilPlus
//
//  Created by Dejan Atanasov on 15/08/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerNibForCellClass(_ cellClass: UITableViewCell.Type) {
        let cellReuseIdentifier = cellClass.cellReuseIdentifier()
        let nibCell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        register(nibCell, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func nextResponder(index: Int){
        var currIndex = -1
        for i in index+1..<index+100{
            if let view = self.superview?.superview?.viewWithTag(i){
                view.becomeFirstResponder()
                currIndex = i
                break
            }
        }
        
        let ind = IndexPath(row: currIndex - 100, section: 0)
        if let nextCell = self.cellForRow(at: ind){
            self.scrollRectToVisible(nextCell.frame, animated: true)
        }
    }
    
    func keyboardRaised(height: CGFloat){
        self.contentInset.bottom = height
        self.scrollIndicatorInsets.bottom = height
    }
    
    func keyboardClosed(){
        self.contentInset.bottom = 0
        self.scrollIndicatorInsets.bottom = 0
        self.scrollRectToVisible(CGRect.zero, animated: true)
    }
    
}
