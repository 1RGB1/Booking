//
//  MyItemsViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit

class MyItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myItemsTableView: UITableView!
    
    var availableItems = [ItemModel]()
    let itemsNetwork = ItemsNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myItemsTableView.delegate = self
        self.myItemsTableView.dataSource = self
        
        self.myItemsTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }
    
    func loadData() {
        
        let userId = Utilities.getSavedUserId()
        
        self.itemsNetwork.getItemsForUserWith(userId: userId) {
            (availableItemsModel, error) in
            
            if error == SUCCESS {
                self.availableItems = (availableItemsModel?.availableItems)!
                self.myItemsTableView.reloadData()
            } else {
                let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                self.present(errorAlertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        Utilities.saveAndDeleteUser(model: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    // MARK: Tableview Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell

        let item = self.availableItems[indexPath.row]
        cell.setModel(model: item, withImages: item.images)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemModel = self.availableItems[indexPath.row]
        performSegue(withIdentifier: "myItemsSegue", sender: itemModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myItemsSegue" {
            let itemInfoViewController = segue.destination as! ItemInfoViewController
            let itemModel = sender as! ItemModel
            
            itemInfoViewController.itemModel = itemModel
            itemInfoViewController.images = itemModel.images
            itemInfoViewController.mainButtonAction = .Cancel
        }
    }
}
