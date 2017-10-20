//
//  InputCell.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class InputCell: BaseCell {

    //MARK: - Private Properties
    @IBOutlet fileprivate weak var inputTxt: UITextField!
    @IBOutlet fileprivate weak var titleLbl: UILabel!
    @IBOutlet fileprivate weak var commentLbl: UILabel!

    //MARK: - Intenal Properties
    var textBlock: ((String) -> ())?
    
    override func setValue(value: Any){
        inputTxt.text = value as? String
    }
    
    @IBAction func onTextChanged(textField: UITextField){
        if let text = textField.text{
            let numberStr = text.replacingOccurrences(of: ".", with: "")
            textBlock?(numberStr)
            inputTxt.text = Int(numberStr)?.stringWithSepator
        }
    }
    override func updateCellWithInput(input: Input) {
        titleLbl.text = input.name
        commentLbl.text = input.comment
    }
}

extension InputCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}
