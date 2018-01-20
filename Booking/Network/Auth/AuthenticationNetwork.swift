//
//  AuthenticationNetwork.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import Alamofire
import ObjectMapper

class AuthenticationNetwork : BaseWebService {
    
    func loginWith(email: String,
                   password: String,
                   completionHandler: @escaping (_ model: UserModel?, _ error: String?) -> ()) {
        
        let parameters = ["email" : email,
                          "password" : password] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(LOGIN_URL, method: POST, parameters: parameters) {
            (response) in
            
            if (response.result.value == nil) {
                completionHandler(nil, self.handleError(errorCode: 999))
                return
            }
            
            let loginModel = Mapper<UserModel>().map(JSONObject: response.result.value)
            let errorDesc = self.handleError(errorCode: (loginModel?.errorCode)!)
            
            completionHandler(loginModel, errorDesc)
        }
    }
    
    func registerWith(username: String, password: String, email: String, phone: String,
                      address: String, latitutde: Double, longitude: Double,
                      completionHandler: @escaping (_ model: BaseModel?, _ error: String?) -> ()) {
        
        let parameters = ["username" : username,
                          "password" : password,
                          "email" : email,
                          "phone" : phone,
                          "address" : address,
                          "lat" : latitutde,
                          "lng" : longitude] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(REGISTER_URL,  method: POST, parameters: parameters) {
            (response) in
            
            if (response.result.value == nil) {
                completionHandler(nil, self.handleError(errorCode: 999))
                return
            }
            
            let baseModel = Mapper<BaseModel>().map(JSONObject: response.result.value)
            let errorDesc = self.handleError(errorCode: (baseModel?.errorCode)!)
            
            completionHandler(baseModel, errorDesc)
        }
    }
}
