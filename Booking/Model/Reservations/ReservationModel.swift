//
//  ReservationModel.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/13/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class ReservationModel : Mappable {
    
    var status: String?
    var item: ItemModel?
    var images: [String]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        status <- map["status"]
        item   <- map["item"]
        images <- map["images"]
    }
}
