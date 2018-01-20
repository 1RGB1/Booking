//
//  WebServiceManager.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import Alamofire

class WebServiceManager {
    
    class func createHTTPRequestWith(_ url: String,
                                     method: HTTPMethod,
                                     parameters: [String : AnyObject],
                                     completionHandler: @escaping (_ httpResponse: DataResponse<Any>) ->()) {
        if let requestURL = URL(string: url) {
            Alamofire.request(requestURL, method: method, parameters: parameters).responseJSON {
                response in
                print(response.debugDescription)
                completionHandler(response)
            }
        }
    }
}
