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

    var textBlock: ((String) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onTextChanged(textField: UITextField){
        if let text = textField.text{
            textBlock?(text)
        }
    }
    override func updateCellWithInput(input: Inputs) {
        titleLbl.text = input.name
    }
}

extension InputCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
