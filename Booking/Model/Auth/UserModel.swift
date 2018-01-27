//
//  UserModel.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class UserModel : BaseModel {
    
    var id: String?
    var username: String?
    var email: String?
    var password: String?
    var phone: String?
    var address: String?
    var lat: String?
    var lng: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id       <- map["data.id"]
        username <- map["data.username"]
        email    <- map["data.email"]
        email    <- map["data.password"]
        phone    <- map["data.phone"]
        address  <- map["data.address"]
        lat      <- map["data.lat"]
        lng      <- map["data.lng"]
    }
    
}
