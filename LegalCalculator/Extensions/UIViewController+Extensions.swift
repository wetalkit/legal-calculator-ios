//
//  UIViewController+Extensions.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation
import SVProgressHUD

extension UIViewController{
    
    class func createFromNib(_ nibName: String? = nil) -> Self {
        return self.init(nibName: nibName ?? "\(self)", bundle: nil)
    }
    
    func showSpinner(_ show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
        
        if show {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
}
