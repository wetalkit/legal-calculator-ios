//
//  MainPresenter.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation

protocol MainPresenterInput
{
    func presentCalculatedResults(response: MainModel.Calculate.Response);
}

protocol MainPresenterOutput: class
{
    func successCalculation(viewModel: MainModel.Calculate.ViewModel)
    func errorCalculation(viewModel: MainModel.Calculate.ViewModel)
}

class MainPresenter: MainPresenterInput {
    weak var output: MainPresenterOutput!
    
    // MARK: - Presentation logic
    func presentCalculatedResults(response: MainModel.Calculate.Response) {
        let viewModel = MainModel.Calculate.ViewModel(baseCost: response.baseCost, isError: response.isError, message: response.message)
        
        if viewModel.isError || response.baseCost == nil{
            if let output = self.output {
                output.errorCalculation(viewModel: viewModel)
            }
        }else{
            if let output = self.output {
                output.successCalculation(viewModel: viewModel)
            }
        }
    }
}
