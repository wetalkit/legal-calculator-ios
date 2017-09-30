//
//  MainWorker.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import Foundation


typealias mainResponseHandler = (_ response: MainModel.Fetch.Response) ->()

class MainWorker{
    
    func fetch(itemId:Int!, keyword:String!, count: String!, success:@escaping(mainResponseHandler), fail:@escaping(mainResponseHandler))
    {
        // NOTE: Do the work
        //call network etc.
        let manager = APIManager()
        
//        manager.fetch(itemId: itemId, keyword: keyword, count: count, success: { (data) in
//            let test = Test(JSON: data)
//            success(TestModel.Fetch.Response(testObj: test, isError: false, message:nil))
//        }) { (error, message) in
//            fail(TestModel.Fetch.Response(testObj: nil, isError: true, message: message))
//        }
    }
}

