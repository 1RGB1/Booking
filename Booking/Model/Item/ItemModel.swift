//
//  ItemModel.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/13/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import ObjectMapper

class ItemModel : Mappable {
    
    var id: Int?
    var title: String?
    var description: String?
    var air_conditioner: Bool?
    var on_beach: Bool?
    var rooms_num: Int?
    var persons_num: Int?
    var breakfast_included: Bool?
    var lunch_included: Bool?
    var dinner_included: Bool?
    var drinks_included: Bool?
    var price: Float?
    var poster_id: Int?
    var category_id: Int?
    var lat: Double?
    var lng: Double?
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
