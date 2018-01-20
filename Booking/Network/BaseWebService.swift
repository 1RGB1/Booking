//
//  BaseWebService.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

class BaseWebService {
    
    func handleError(errorCode: Int) -> String {
        
        var errorDesc: String
        
        switch errorCode {
        case 0:
            errorDesc = "Success"
            break
        case -100:
            errorDesc = "Internal server error"
            break
        case -101:
            errorDesc = "Required parameters not sent"
            break
        case -102:
            errorDesc = "Username or password doesn't match"
            break
        case -103:
            errorDesc = "Email is already registered"
            break
        case -104:
            errorDesc = "Couldn't process request, try again"
            break
        default:
            errorDesc = "Opps, something went wrong"
            break
        }
        
        return errorDesc
    }
}
