//
//  BaseCell.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
    
    var type: MainCellType!
    
    func setValue(value: Any){}

    func updateCellWithInput(input: Input){}

    
}
