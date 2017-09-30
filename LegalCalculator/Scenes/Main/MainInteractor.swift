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
//    func fetchItems(request: TestModel.Fetch.Request)
}

protocol MainInteractorOutput
{
//    func presentFetchResults(response: TestModel.Fetch.Response);
}

class MainInteractor : MainInteractorInput
{
    
    var output: MainInteractorOutput!
    var worker: MainWorker!
    
    func fetchItems(request: MainModel.Fetch.Request) {
        if request.itemId == nil || request.count == nil || request.keyword == nil {
//            return output.presentFetchResults(response: MainModel.Fetch.Response(object: nil,isError: true, message: "Fields may not be empty."))
        }
        worker = MainWorker()
//        worker.fetch(name: request.name, type: request.type, count: request.count, success: { (object) in
//            self.output.presentFetchResults(response: MainModel.Fetch.Response(object: object, isError: false, message: nil))
//        }) { (error, message) in
//            self.output.presentFetchResults(response: MainModel.Fetch.Response(object: nil, isError: true, message: message))
//        }
    }
}
