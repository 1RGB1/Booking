//
//  MyReservationsViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/2/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit

class MyReservationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var reservationsTableView: UITableView!
    
    var myReservations = [ReservationModel]()
    let itemsNetwork = ItemsNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reservationsTableView.delegate = self
        self.reservationsTableView.dataSource = self
        
        self.reservationsTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }
    
    func loadData() {
        
        let userId = Utilities.getSavedUserId()
        
        self.itemsNetwork.getReservationsForUserWith(userId: userId) {
            (myReservationsModel, error) in
            
            if error == SUCCESS {
                self.myReservations = (myReservationsModel?.reservations)!
                self.reservationsTableView.reloadData()
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
        return self.myReservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        let reservation = self.myReservations[indexPath.row]
        cell.setModel(model: reservation.item, withImages: reservation.images)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reservationModel = self.myReservations[indexPath.row]
        performSegue(withIdentifier: "myReservationsSegue", sender: reservationModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myReservationsSegue" {
            let itemInfoViewController = segue.destination as! ItemInfoViewController
            let reservationModel = sender as! ReservationModel
            
            itemInfoViewController.itemModel = reservationModel.item
            itemInfoViewController.images = reservationModel.images
            itemInfoViewController.mainButtonAction = .Approve
            itemInfoViewController.subButtonAction = .Deny
        }
    }
}
