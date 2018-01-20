//
//  UserModel.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class UserModel : BaseModel {
    
    var id: Int?
    var username: String?
    var email: String?
    var password: String?
    var phone: Double?
    var address: String?
    var lat: Double?
    var lng: Double?
    
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
