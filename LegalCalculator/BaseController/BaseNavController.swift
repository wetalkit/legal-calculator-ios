//
//  BaseNavController.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 03/10/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class BaseNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.topItem?.title = ""
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.themeBlue()
        navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
    }    
}
