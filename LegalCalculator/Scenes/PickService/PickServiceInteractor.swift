//
//  PickServiceInteractor.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation

protocol PickServiceInteractorInput
{
    func fetchServices()
}

protocol PickServiceInteractorOutput
{
    func presentServices(response: PickServiceModel.Fetch.Response);
}

class PickServiceInteractor : PickServiceInteractorInput
{
    
    var output: PickServiceInteractorOutput!
    var worker: PickServiceWorker!
    
    func fetchServices() {
        worker = PickServiceWorker()
        worker.fetch(success: { (services) in
            self.output.presentServices(response: PickServiceModel.Fetch.Response(services: services, isError: services == nil, message: services == nil ? "No Results Found." : nil))
        }) { (error) in
            self.output.presentServices(response: PickServiceModel.Fetch.Response(services: nil, isError: true, message: "No Results Found."))
        }
    }
}
