//
//  MainModels.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

struct MainModel{
    struct Calculate {
        struct Request
        {
            var params: [String : Any]?
        }
        struct Response
        {
            var baseCost: BaseCost?
            var isError: Bool
            var message: String?
        }
        struct ViewModel
        {
            var baseCost: BaseCost!
            var isError: Bool
            var message: String?
        }
    }
}
