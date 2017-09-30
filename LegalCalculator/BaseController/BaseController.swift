//
//  BaseController.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardFrame.height + 20
        keyboardOpened(height: height)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        keyboardHidden()
    }
    
    /* override to get keyboard height*/
    func keyboardOpened(height: CGFloat){
        
    }
    
    /* override to remove keyboard height*/
    func keyboardHidden(){
        
    }

    func showPickerController(pickerOptions: [String], selectedIndex: ((Int) -> Void)?){
        let vc = PickerController.createFromNib()
        let picker = PickerView()
        
        vc.actionBlock = {
            let index = picker.selectedRow(inComponent: 0)
            selectedIndex?(index)
        }
        
        picker.setComponents(pickerOptions, selectedRow: 0)
        vc.showedView = picker
        vc.showModally()
    }

}
