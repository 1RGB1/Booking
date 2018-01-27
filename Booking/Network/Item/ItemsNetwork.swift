//
//  ItemsNetwork.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/13/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import Alamofire
import ObjectMapper

class ItemsNetwork : BaseWebService {
    
    func requestReservationFor(item_id: Int,
                               user_id: Int,
                               completionHandler: @escaping (_ model: BaseModel?, _ error: String?) -> ()) {
        
        let parameters = ["user_id" : user_id,
                          "item_id" : item_id] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(REQUEST_RESERVATION_URL, method: POST, parameters: parameters) {
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
    
    func approveReservationFor(reservation_id: Int,
                            completionHandler: @escaping (_ model: BaseModel?, _ error: String?) -> ()) {
        
        let parameters = ["reservation_id" : reservation_id] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(APPROVE_RESERVATION_URL, method: POST, parameters: parameters) {
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
    
    func denyReservationFor(reservation_id: Int,
                            completionHandler: @escaping (_ model: BaseModel?, _ error: String?) -> ()) {
        
        let parameters = ["reservation_id" : reservation_id] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(DENY_RESERVATION_URL, method: POST, parameters: parameters) {
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
    
    func cancelReservationFor(reservation_id: Int,
                         completionHandler: @escaping (_ model: BaseModel?, _ error: String?) -> ()) {
        
        let parameters = ["reservation_id" : reservation_id] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(CANCEL_RESERVATION_URL, method: GET, parameters: parameters) {
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
    
    func getReservationsForUserWith(userId: Int,
                                    completionHandler: @escaping (_ model: MyReservationsModel?, _ error: String?) -> ()) {
        
        let parameters = ["user_id" : userId] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(USER_RESERTVATIONS_URL, method: GET, parameters: parameters) {
            (response) in
            
            if (response.result.value == nil) {
                completionHandler(nil, self.handleError(errorCode: 999))
                return
            }
            
            let userReservationsModel = Mapper<MyReservationsModel>().map(JSONObject: response.result.value)
            let errorDesc = self.handleError(errorCode: (userReservationsModel?.errorCode)!)
            
            completionHandler(userReservationsModel, errorDesc)
        }
    }
    
    func getItemsForUserWith(userId: Int,
                             completionHandler: @escaping (_ model: AvailableItemsModel?, _ error: String?) -> ()) {
        
        let parameters = ["user_id" : userId] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(USER_ITEMS_URL,  method: GET, parameters: parameters) {
            (response) in
            
            if (response.result.value == nil) {
                completionHandler(nil, self.handleError(errorCode: 999))
                return
            }
            
            let availableItemsModel = Mapper<AvailableItemsModel>().map(JSONObject: response.result.value)
            let errorDesc = self.handleError(errorCode: (availableItemsModel?.errorCode)!)
            
            completionHandler(availableItemsModel, errorDesc)
        }
    }
    
    func addNewItemWith(title: String,
                     description: String,
                     price: Float,
                     air_conditioner: Bool,
                     on_beach: Bool,
                     rooms_num: Int,
                     persons_num: Int,
                     breakfast_included: Bool,
                     lunch_included: Bool,
                     dinner_included: Bool,
                     drinks_included: Bool,
                     lat: Double,
                     lng: Double,
                     images: [Int],
                     poster_id: Int,
                     category_id: Int,
                     completionHandler: @escaping (_ model: BaseModel?, _ error: String?) -> ()) {
        
        let parameters = ["title": title,
                          "description": description,
                          "price": price,
                          "air_conditioner": air_conditioner,
                          "on_beach": on_beach,
                          "rooms_num": rooms_num,
                          "persons_num": persons_num,
                          "breakfast_included": breakfast_included,
                          "lunch_included": lunch_included,
                          "dinner_included": dinner_included,
                          "drinks_included": drinks_included,
                          "lat": lat,
                          "lng": lng,
                          "images": images,
                          "poster_id": poster_id,
                          "category_id": category_id,] as [String: AnyObject]
        
        WebServiceManager.createHTTPRequestWith(ADD_ITEM_URL, method: POST, parameters: parameters) {
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
    
    func uploadImage(image: String,
                     completionHandler: @escaping (_ model: ImageModel?, _ error: String?) -> ()) {
        
        let parameters = ["image" : image] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(UPLOAD_IMAGE_URL, method: GET, parameters: parameters) {
            (response) in
            
            if (response.result.value == nil) {
                completionHandler(nil, self.handleError(errorCode: 999))
                return
            }
            
            let imageModel = Mapper<ImageModel>().map(JSONObject: response.result.value)
            let errorDesc = self.handleError(errorCode: (imageModel?.errorCode)!)
            
            completionHandler(imageModel, errorDesc)
        }
    }
    
    func searchWith(query: String,
                    completionHandler: @escaping (_ model: AvailableItemsModel?, _ error: String?) -> ()) {
        
        let parameters = ["query" : query] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(SEARCH_URL, method: GET, parameters: parameters) {
            (response) in
            
            if (response.result.value == nil) {
                completionHandler(nil, self.handleError(errorCode: 999))
                return
            }
            
            let availableItemsModel = Mapper<AvailableItemsModel>().map(JSONObject: response.result.value)
            let errorDesc = self.handleError(errorCode: (availableItemsModel?.errorCode)!)
            
            completionHandler(availableItemsModel, errorDesc)
        }
    }
    
    func getAvailableItemsBy(categoryId: Category,
                             completionHandler: @escaping (_ model: AvailableItemsModel?, _ error: String?) -> ()) {
        
        var parameters : [String : AnyObject]
        
        if categoryId == .All {
            parameters = [:]
        } else {
            parameters = ["categoryID" : categoryId.rawValue] as [String : AnyObject]
        }
        
        WebServiceManager.createHTTPRequestWith(GET_AVAIL_ITEMS_URL, method: GET, parameters: parameters) {
            (response) in
            
            if (response.result.value == nil) {
                completionHandler(nil, self.handleError(errorCode: 999))
                return
            }
            
            let availableItemsModel = Mapper<AvailableItemsModel>().map(JSONObject: response.result.value)
            let errorDesc = self.handleError(errorCode: (availableItemsModel?.errorCode)!)
            
            completionHandler(availableItemsModel, errorDesc)
        }
    }
}









