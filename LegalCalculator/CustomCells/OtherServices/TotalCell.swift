//
//  TotalCell.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 01/10/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class TotalCell: UITableViewCell {
    
    //MARK: - Private Properties
    @IBOutlet fileprivate weak var totalLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCellWith(total: String){
        totalLbl.text = total
    }
}
