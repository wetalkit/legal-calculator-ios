//
//  NetworkManager.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIManager: Request {
    
    func fetchServices(onCompletion: ((JSON) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        requestWith(endUrl: API.SERVICES, method: .get, parameters: nil, onCompletion: { (json) in
            if let j = json{
                print(j)
                onCompletion?(j)
            }
        }) { (error) in
            onError?(error)
        }
    }
    
}
