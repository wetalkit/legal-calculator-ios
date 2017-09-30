//
//  MainCellType.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation
import UIKit

public enum MainCellType: Int{
    case input = 1
    case dropdown = 2
    case button

    func cellType() -> UITableViewCell.Type{
        switch self {
        case .input: return InputCell.self
        case .dropdown: return DropdownCell.self
        case .button: return ButtonCell.self
        }
    }
}
