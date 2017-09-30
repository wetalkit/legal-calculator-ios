//
//  PickServiceConfigurator.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Connect View, Interactor, and Presenter
extension PickServiceController: PickServicePresenterOutput
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        router.passDataToNextScene(segue: segue)
    }
}

extension PickServiceInteractor: PickServiceControllerOutput
{
    
}

extension PickServicePresenter: PickServiceInteractorOutput
{
    
}

class PickServiceConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = PickServiceConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: PickServiceController)
    {
        let router = PickServiceRouter()
        router.viewController = viewController
        
        let presenter = PickServicePresenter()
        presenter.output = viewController
        
        let interactor = PickServiceInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
    
}
