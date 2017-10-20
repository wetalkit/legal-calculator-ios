//
//  Request.swift
//

import Foundation
import Alamofire
import SwiftyJSON

class Request {
    
    static let shared = Request()
    
    func getUrl(endUrl: String) -> String{
        var url = "\(API.BASE_URL)\(endUrl)"
        let allowedCharacterSet = (CharacterSet(charactersIn: "! ").inverted)
        if let escUrl = url.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            url = escUrl
        }
        return url
    }
    
    func requestWith(endUrl: String, method: HTTPMethod, parameters: Parameters?, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        
        let url = getUrl(endUrl: endUrl)

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-type" : "application/json"
        ]
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false;

            switch response.result{
            case .success:
                if let d = response.data{
                    let json = JSON(d)
                    onCompletion?(json)
                }else{
                    onCompletion?(nil)
                }
            case .failure(let error):
                onError?(error)
            }
        }
    }
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}


