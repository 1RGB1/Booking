//
//  ImagesNetwork.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/31/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import Alamofire
import ObjectMapper

class ImagesNetwork : BaseWebService {
    func uploadImage(image: String,
                     completionHandler: @escaping (_ model: ImageModel?, _ error: String?) -> ()) {
        
        let parameters = ["image" : image] as [String : AnyObject]
        
        WebServiceManager.createHTTPRequestWith(UPLOAD_IMAGE_URL, method: POST, parameters: parameters) {
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
}
