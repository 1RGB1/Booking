//
//  AddNewItemViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController {

    let itemsNetwork = ItemsNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        
        //lessa msh 3aref let images: [Int]?
        //will show and hide choose wheel contains all categories let category_id: Int?
        
        self.itemsNetwork.addNewItemWith(title: <#T##String#>,
                                         description: <#T##String#>,
                                         price: <#T##Float#>,
                                         air_conditioner: <#T##Bool#>,
                                         on_beach: <#T##Bool#>,
                                         rooms_num: <#T##Int#>,
                                         persons_num: <#T##Int#>,
                                         breakfast_included: <#T##Bool#>,
                                         lunch_included: <#T##Bool#>,
                                         dinner_included: <#T##Bool#>,
                                         drinks_included: <#T##Bool#>,
                                         lat: <#T##Double#>,
                                         lng: <#T##Double#>,
                                         images: <#T##[Int]#>,
                                         poster_id: Utilities.getSavedUserId(),
                                         category_id: <#T##Int#>) {
            (baseModel, error) in
            
        }
        
    }
}
