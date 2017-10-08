//
//  InputSection.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 07/10/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation

enum InputSectionType: String{
    case mandatory = "Задолжителни Полиња"
    case optional = "Незадолжителни Полиња"
}

public struct InputSection {
    var type: InputSectionType!
    var inputs: [Input]!
}
