//
//  CostCell.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 01/10/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class CostCell: UITableViewCell {
    
    //MARK: - Private Properties
    @IBOutlet fileprivate weak var costLbl: UILabel!
    @IBOutlet fileprivate weak var nameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCellWithCost(cost: Costs){
        print(cost.name)
        print(cost.cost)
        
        nameLbl.text = cost.name
        costLbl.text = "\(cost.cost) МКД"
    }    
}
