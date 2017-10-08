//
//  DropdownCell.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class DropdownCell: BaseCell {

    //MARK: - Private Properties
    @IBOutlet fileprivate weak var dropdownBtn: UIButton!
    @IBOutlet fileprivate weak var titleLbl: UILabel!

    fileprivate var options: [String]?
    
    //MARK: - Internal Properties
    var onDropdownBlock: (([String]) -> ())?

    override func setValue(value: Any) {
        setTitle(title: "\(value)")
    }
    
    func setPickedItem(text: String){
        dropdownBtn.setTitle(text, for: .normal)
    }
    
    override func updateCellWithInput(input: Input) {
        options = input.attributes?.options
        titleLbl.text = input.name
        setTitle(title: input.attributes?.placeholder ?? "")
    }
    
    func setTitle(title: String){
        dropdownBtn.setTitle(title, for: .normal)
        dropdownBtn.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    @IBAction func onDropdownButton(btn: UIButton){
        if let o = options{
            onDropdownBlock?(o)
        }
    }
}
