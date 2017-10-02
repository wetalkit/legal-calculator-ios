//
//  MainInteractor.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation


protocol MainInteractorInput
{
    func calculate(request: MainModel.Calculate.Request)
}

protocol MainInteractorOutput
{
    func presentCalculatedResults(response: MainModel.Calculate.Response);
}

class MainInteractor : MainInteractorInput
{
    
    var output: MainInteractorOutput!
    var worker: MainWorker!
    
    func calculate(request: MainModel.Calculate.Request) {
        guard let params = request.params else {
            output.presentCalculatedResults(response: MainModel.Calculate.Response(baseCost: nil,isError: true, message: "Fields may not be empty."))
            return
        }

        worker = MainWorker()
        worker.calculate(params: params, success: { (response) in
            self.output.presentCalculatedResults(response: response)
        }) { (error) in
            self.output.presentCalculatedResults(response: error)
        }
    }
}
