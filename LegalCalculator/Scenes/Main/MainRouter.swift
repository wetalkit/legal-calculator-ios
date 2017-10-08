//
//  MainRouter.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation
import UIKit

protocol MainRouterInput {

}

class MainRouter: MainRouterInput
{
    weak var viewController: MainController!
    
    // MARK: - Communication
    func passDataToNextScene(segue: UIStoryboardSegue)
    {
        // NOTE: Teach the router which scenes it can communicate with
    }
}
