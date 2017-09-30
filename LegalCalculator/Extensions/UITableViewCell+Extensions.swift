//
//  UITableViewCell+Extensions.swift
//  BilPlus
//
//  Created by Dejan Atanasov on 15/08/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    class func cellReuseIdentifier() -> String {
        return "\(self)"
    }
}

