//
//  PickServiceWorker.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation

typealias pickServiceResponseHandler = (_ response: [Service]?) ->()

class PickServiceWorker{
    
    func fetch(success:@escaping(pickServiceResponseHandler), fail:@escaping(pickServiceResponseHandler))
    {
        let manager = APIManager()
        manager.fetchServices(onCompletion: { (json) in
            let s = Services(json: json)
            success(s.services)
        }) { (error) in
            fail(nil)
        }
    }
}

