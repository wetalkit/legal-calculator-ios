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
    
    //MARK: - Internal Properties
    var onDropdownBlock: (([String]) -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setPickedItem(text: String){
        dropdownBtn.setTitle(text, for: .normal)
    }
    
    override func updateCellWithInput(input: Inputs) {
        
    }
    @IBAction func onDropdownButton(btn: UIButton){
        onDropdownBlock?(["1", "2", "3", "4", "5"])
    }
}
