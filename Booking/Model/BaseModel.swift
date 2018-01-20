//
//  BaseModel.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class BaseModel : Mappable {
    
    var errorCode: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        errorCode <- map["errorCode"]
    }
}
