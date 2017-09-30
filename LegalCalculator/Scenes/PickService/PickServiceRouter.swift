//
//  PickServiceRouter.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation
import UIKit

protocol PickServiceRouterInput {
    func showMainVC(service: Service)
}

class PickServiceRouter: PickServiceRouterInput
{
    weak var viewController: PickServiceController!
    fileprivate var service: Service?
    
    func showMainVC(service: Service) {
        self.service = service
        viewController.performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
    // MARK: - Communication
    func passDataToNextScene(segue: UIStoryboardSegue)
    {
        // NOTE: Teach the router which scenes it can communicate with
        if segue.identifier == "toMainVC", let s = service {
            let vc = segue.destination as! MainController
            vc.service = s
        }
    }
}
