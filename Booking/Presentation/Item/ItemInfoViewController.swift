//
//  ItemInfoViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/20/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit
import Kingfisher

class ItemInfoViewController: UIViewController {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeDescriptionLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var subButton: UIButton!
    
    var itemModel : ItemModel?
    var images : [String]?
    var mainButtonAction : ReservationsActions?
    var subButtonAction : ReservationsActions?
    
    let itemsNetwork = ItemsNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        
        self.downloadImage()
        
        if itemModel?.title != nil && itemModel?.title != "" {
            self.navigationItem.title = itemModel?.title
        } else {
            self.navigationItem.title = "Item"
        }
        
        if itemModel?.description != nil && itemModel?.description != "" {
            self.placeDescriptionLabel.text = itemModel?.description
        } else {
            self.placeDescriptionLabel.text = ""
        }
        
        if let mainAction = mainButtonAction {
            self.mainButton.setTitle(mainAction.rawValue, for: .normal)
        } else {
            self.mainButton.isHidden = true
        }
        
        if let subAction = subButtonAction {
            self.subButton.setTitle(subAction.rawValue, for: .normal)
        } else {
            self.subButton.isHidden = true
        }
    }
    
    func downloadImage() {
        self.placeImageView.kf.indicatorType = .activity
        
        if let images = images {
            if images.count != 0 {
                let imageURL = images[0]
                
                if imageURL != "" {
                    let remoteImageURL = URL(string: imageURL)
                    self.placeImageView.kf.setImage(with: remoteImageURL)
                }
            }
        }
    }

    @IBAction func mainButtonPressed(_ sender: Any) {
        switch mainButtonAction! {
        case .Request:
            self.requestReservation()
            break
        case .Approve:
            self.approveReservation()
            break
        case .Cancel:
            self.cancelReservation()
            break
        default:
            break
        }
    }
    
    @IBAction func subButtonPressed(_ sender: Any) {
        switch subButtonAction! {
        case .Deny:
            self.denyReservation()
            break
        default:
            break
        }
    }
    
    func requestReservation() {
        if let model = itemModel, let itemId = model.id, let posterId = model.poster_id {
            self.itemsNetwork.requestReservationFor(item_id: Int(itemId)!, user_id: Int(posterId)!) {
                (baseModel, error) in
                
                if error == SUCCESS {
                    let alertController = UIAlertController(title: SUCCESS, message: RESERVATION_REQUESTED, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            }
        } else {
            let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: UNKNOWN)
            self.present(errorAlertController, animated: true, completion: nil)
        }
    }
    
    func approveReservation() {
        if let model = itemModel, let reservation_id = model.id {
            self.itemsNetwork.approveReservationFor(reservation_id: Int(reservation_id)!) {
                (baseModel, error) in
                
                if error == SUCCESS {
                    let alertController = UIAlertController(title: SUCCESS, message: RESERVATION_APPROVED, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            }
        } else {
            let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: UNKNOWN)
            self.present(errorAlertController, animated: true, completion: nil)
        }
    }
    
    func cancelReservation() {
        if let model = itemModel, let reservation_id = model.id {
            self.itemsNetwork.cancelReservationFor(reservation_id: Int(reservation_id)!) {
                (baseModel, error) in
                
                if error == SUCCESS {
                    let alertController = UIAlertController(title: SUCCESS, message: RESERVATION_CANCELLED, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            }
        } else {
            let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: UNKNOWN)
            self.present(errorAlertController, animated: true, completion: nil)
        }
    }
    
    func denyReservation() {
        if let model = itemModel, let reservation_id = model.id {
            self.itemsNetwork.denyReservationFor(reservation_id: Int(reservation_id)!) {
                (baseModel, error) in
                
                if error == SUCCESS {
                    let alertController = UIAlertController(title: SUCCESS, message: RESERVATION_DENIED, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            }
            
        } else {
            let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: UNKNOWN)
            self.present(errorAlertController, animated: true, completion: nil)
        }
    }
    
}
