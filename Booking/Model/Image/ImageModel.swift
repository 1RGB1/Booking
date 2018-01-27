//
//  ImageModel.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/13/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class ImageModel : BaseModel {
    
    var imageId: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        imageId <- map["image_id"]
    }
}
