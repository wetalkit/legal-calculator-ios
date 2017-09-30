//
//  PickServicePresenter.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation

protocol PickServicePresenterInput
{
    func presentServices(response: PickServiceModel.Fetch.Response);
}

protocol PickServicePresenterOutput: class
{
        func successFetchedServices(viewModel: PickServiceModel.Fetch.ViewModel)
        func errorFetchingServices(viewModel: PickServiceModel.Fetch.ViewModel)
}

class PickServicePresenter: PickServicePresenterInput {
    
    weak var output: PickServicePresenterOutput!
    
    // MARK: - Presentation logic
    func presentServices(response: PickServiceModel.Fetch.Response) {
        if !response.isError{
            let viewModel = PickServiceModel.Fetch.ViewModel(services: response.services, isError: response.isError, message: nil)
            output.successFetchedServices(viewModel: viewModel)
        }else{
            let viewModel = PickServiceModel.Fetch.ViewModel(services: nil, isError: response.isError, message: response.message)
            output.errorFetchingServices(viewModel: viewModel)
        }
    }    
}
