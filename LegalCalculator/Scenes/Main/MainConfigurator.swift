//
//  MainConfigurator.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Connect View, Interactor, and Presenter
extension MainController: MainPresenterOutput
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        router.passDataToNextScene(segue: segue)
    }
}

extension MainInteractor: MainControllerOutput
{
    
}

extension MainPresenter: MainInteractorOutput
{
    
}

class MainConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = MainConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: MainController)
    {
        let router = MainRouter()
        router.viewController = viewController
        
        let presenter = MainPresenter()
        presenter.output = viewController
        
        let interactor = MainInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
    
}
