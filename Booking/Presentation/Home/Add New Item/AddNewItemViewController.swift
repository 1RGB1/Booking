//
//  AddNewItemViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit
import CoreLocation

class AddNewItemViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var movingScrollView: UIScrollView!
    
    @IBOutlet weak var titleText: FancyField!
    @IBOutlet weak var descriptionText: FancyField!
    @IBOutlet weak var priceText: FancyField!
    @IBOutlet weak var numberOfRoomsText: FancyField!
    @IBOutlet weak var numberOfPersonsText: FancyField!
    @IBOutlet weak var latitudeText: FancyField!
    @IBOutlet weak var longitudeText: FancyField!
    
    @IBOutlet weak var acSwitch: UISwitch!
    @IBOutlet weak var beachSwitch: UISwitch!
    @IBOutlet weak var drinksSwitch: UISwitch!
    @IBOutlet weak var breakfastSwitch: UISwitch!
    @IBOutlet weak var lunchSwitch: UISwitch!
    @IBOutlet weak var dinnerSwitch: UISwitch!
    
    @IBOutlet weak var selectCategoryButton: FancyButton!
    @IBOutlet var categoriesButtons: [FancyButton]!
    
    //MARK: Locals
    let itemsNetwork = ItemsNetwork()
    var categoryId = -1
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: TextFieldDelegate Functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == latitudeText) {
            self.movingScrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        }
        
        if (textField == longitudeText) {
            self.movingScrollView.setContentOffset(CGPoint(x: 0, y: 90), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.movingScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    //MARK: Local Functions
    func prepareInputs() -> Bool {
        if (self.titleText.text == nil || self.titleText.text == "") ||
           (self.descriptionText.text == nil || self.descriptionText.text == "") ||
           (self.priceText.text == nil || self.priceText.text == "") ||
           (self.numberOfRoomsText.text == nil || self.numberOfRoomsText.text == "") ||
           (self.numberOfPersonsText.text == nil || self.numberOfPersonsText.text == "") ||
           (self.latitudeText.text == nil || self.latitudeText.text == "") ||
           (self.longitudeText.text == nil || self.longitudeText.text == "") {
            return false
        }
        
        return true
    }
    
    //MARK: Buttons Actions
    @IBAction func logoutPressed(_ sender: Any) {
        Utilities.saveAndDeleteUser(model: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func selectCategoryPressed(_ sender: FancyButton) {
        self.categoriesButtons.forEach { (category) in
            UIView.animate(withDuration: 0.75, animations: {
                category.isHidden = !category.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func categoryPressed(_ sender: FancyButton) {
        self.selectCategoryButton.setTitle(sender.titleLabel?.text, for: .normal)
        self.categoryId = sender.tag
        
        self.categoriesButtons.forEach { (category) in
            UIView.animate(withDuration: 0.75, animations: {
                category.isHidden = !category.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func selectItemLocationFromMap(_ sender: FancyButton) {
    }
    
    @IBAction func uploadImagePressed(_ sender: FancyButton) {
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        
//        if (self.prepareInputs()) {
//            self.itemsNetwork.addNewItemWith(title: self.titleText.text!,
//                                             description: self.descriptionText.text!,
//                                             price: Float(self.priceText.text!)!,
//                                             air_conditioner: (self.acSwitch.isOn ? YES : NO),
//                                             on_beach: (self.beachSwitch.isOn ? YES : NO),
//                                             rooms_num: Int(self.numberOfRoomsText.text!)!,
//                                             persons_num: Int(self.numberOfPersonsText.text!)!,
//                                             breakfast_included: (self.breakfastSwitch.isOn ? YES : NO),
//                                             lunch_included: (self.lunchSwitch.isOn ? YES : NO),
//                                             dinner_included: (self.dinnerSwitch.isOn ? YES : NO),
//                                             drinks_included: (self.drinksSwitch.isOn ? YES : NO),
//                                             lat: Double(self.latitudeText.text!)!,
//                                             lng: Double(self.longitudeText.text!)!,
//                                             images: <#T##[Int]#>,
//                                             poster_id: Utilities.getSavedUserId(),
//                                             category_id: self.categoryId) {
//                                                (baseModel, error) in
//
//            }
//        } else {
//            let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: MANDATORY)
//            self.present(errorAlertController, animated: true, completion: nil)
//        }
    }
}
