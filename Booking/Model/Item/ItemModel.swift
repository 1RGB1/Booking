//
//  ItemModel.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/13/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class ItemModel : Mappable {
    
    var id: String?
    var title: String?
    var description: String?
    var air_conditioner: String?
    var on_beach: String?
    var rooms_num: String?
    var persons_num: String?
    var breakfast_included: String?
    var lunch_included: String?
    var dinner_included: String?
    var drinks_included: String?
    var price: String?
    var poster_id: String?
    var category_id: String?
    var lat: String?
    var lng: String?
    var images: [String]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        air_conditioner    <- map["air_conditioner"]
        breakfast_included <- map["breakfast_included"]
        category_id        <- map["category_id"]
        description        <- map["description"]
        dinner_included    <- map["dinner_included"]
        drinks_included    <- map["drinks_included"]
        id                 <- map["id"]
        images             <- map["images"]
        lat                <- map["lat"]
        lng                <- map["lng"]
        lunch_included     <- map["lunch_included"]
        on_beach           <- map["on_beach"]
        persons_num        <- map["persons_num"]
        rooms_num          <- map["rooms_num"]
        poster_id          <- map["poster_id"]
        price              <- map["price"]
        title              <- map["title"]
    }
}
