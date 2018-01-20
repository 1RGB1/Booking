//
//  AvailableItemsModel.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/13/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class AvailableItemsModel : BaseModel {
    
    var availableItems : [ItemModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        availableItems <- map["items"];
    }
}
