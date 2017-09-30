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
//    func presentFetchResults(response: TestModel.Fetch.Response);
}

protocol MainPresenterOutput: class
{
//    func successFetchedItems(viewModel: TestModel.Fetch.ViewModel)
//    func errorFetchingItems(viewModel: TestModel.Fetch.ViewModel)
}

class MainPresenter: MainPresenterInput {
    weak var output: MainPresenterOutput!
    
    // MARK: - Presentation logic
//    func presentFetchResults(response: TestModel.Fetch.Response) {
//        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
//        let viewModel = TestModel.Fetch.ViewModel(name: response.testObj?.name, date: response.testObj?.date, desc: response.testObj?.desc, isError: response.isError, message: response.message)
//
//        if viewModel.isError{
//            if let output = self.output {
//                output.errorFetchingItems(viewModel: viewModel)
//            }
//        }else{
//            if let output = self.output {
//                output.successFetchedItems(viewModel: viewModel)
//            }
//        }
//    }
}
