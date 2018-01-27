//
//  ItemTableViewCell.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/13/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class ItemTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setModel(model: ItemModel?, withImages images: [String]?) {
        
        self.itemImageView.kf.indicatorType = .activity
        
        if let item = model {
            if let images = images {
                if images.count != 0 {
                    let imageURL = images[0]
                    
                    if imageURL != "" {
                        downloadImageFrom(url: imageURL)
                    }
                }
            }
            
            if let title = item.title { self.titleLbl.text = title }
            if let desc = item.description { self.descriptionLbl.text = desc }
        }
    }
    
    func downloadImageFrom(url: String) {
        let remoteImageURL = URL(string: url)
        self.itemImageView.kf.setImage(with: remoteImageURL)
    }
}
