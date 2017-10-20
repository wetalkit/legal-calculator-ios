//
//  ButtonCell.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class ButtonCell: BaseCell {
    
    //MARK: - Private Properties
    @IBOutlet fileprivate weak var actionBtn: UIButton!
    
    //MARK: - Internal Properties
    var onActionBlock: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func updateCellWithInput(input: Input) {
        
    }
    
    @IBAction func onActionButton(btn: UIButton){
        onActionBlock?()
    }

}
