//
//  MainModels.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

struct MainModel{
    struct Fetch {
        struct Request
        {
            var itemId = 0
            var keyword: String?
            var count: String?
        }
        struct Response
        {
//            var testObj: Test?
            var isError: Bool
            var message: String?
        }
        struct ViewModel
        {
            var name: String?
            var date: String?
            var desc: String?
            var isError: Bool
            var message: String?
        }
    }
}
