//
//  BottomTextField.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 08/10/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class BottomTextField: UITextField {

    override func draw(_ rect: CGRect) {
        tintColor = UIColor.black.withAlphaComponent(0.3)
        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY)
        
        let path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 2.0
        tintColor.setStroke()
        path.stroke()
    }
}
