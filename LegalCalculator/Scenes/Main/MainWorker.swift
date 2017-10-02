//
//  MainWorker.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation


typealias mainResponseHandler = (_ response: MainModel.Calculate.Response) ->()

class MainWorker{
    
    func calculate(params: [String : Any], success:@escaping(mainResponseHandler), fail:@escaping(mainResponseHandler))
    {
        let manager = APIManager()
        manager.calculate(params: params, onCompletion: { (response) in
            let cost = BaseCost(json: response)
            success(MainModel.Calculate.Response(baseCost: cost, isError: false, message:nil))
        }) { (error) in
            success(MainModel.Calculate.Response(baseCost: nil, isError: true, message:"Something went wrong"))
        }
    }
}

