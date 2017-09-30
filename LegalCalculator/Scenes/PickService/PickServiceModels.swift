//
//  PickServiceModels.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation

struct PickServiceModel{
    struct Fetch {
        struct Request{}
        
        struct Response
        {
            var services: [Service]?
            var isError: Bool
            var message: String?
        }
        struct ViewModel
        {
            var services: [Service]?
            var isError: Bool
            var message: String?
        }
    }
}
