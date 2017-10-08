//
//  Int+Extensions.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 07/10/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var stringWithSepator: String {
        return Number.withSeparator.string(from: NSNumber(value: hashValue)) ?? ""
    }
}
struct Number {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}
