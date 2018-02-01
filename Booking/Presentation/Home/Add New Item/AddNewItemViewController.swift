//
//  AddNewItemViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit
import CoreLocation
import OpalImagePicker
import ImagePicker

class AddNewItemViewController: UIViewController, UITextFieldDelegate, OpalImagePickerControllerDelegate, ImagePickerDelegate, LocationProtocol {
    
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
    @IBOutlet weak var addNewItem: FancyButton!
    
    //MARK: Locals
    let itemsNetwork = ItemsNetwork()
    let imagesNetwork = ImagesNetwork()
    var imagePicker = OpalImagePickerController()
    var imagePickerController = ImagePickerController()
    var imagesId = [Int]()
    var categoryId = -1
    var itemLocation : [String]?
    var alertAlreadyAppeard = false
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureOpalImagePicker()
        self.configureImagePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let location = itemLocation {
            self.latitudeText.text = location[0]
            self.longitudeText.text = location[1]
        }
    }
    
    //MARK: Configurations Functions
    func configureOpalImagePicker() {
        
        imagePicker.selectionTintColor = UIColor.white.withAlphaComponent(0.7)
        imagePicker.selectionImageTintColor = UIColor.black
        imagePicker.maximumSelectionsAllowed = 2
        
        //Change default localized strings displayed to the user
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
        imagePicker.configuration = configuration
    }
    
    func configureImagePicker() {
        imagePickerController.imageLimit = 2

        var configuration = Configuration()
        configuration.doneButtonTitle = "Done"
        configuration.noImagesTitle = "Sorry! There are no images here!"
        configuration.recordLocation = false

        imagePickerController = ImagePickerController(configuration: configuration)
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
    
    func uploadImages(images: [String], picker: UIViewController) {
        for imageString in images {
            self.imagesNetwork.uploadImage(image: imageString, completionHandler: {
                (imageModel, error) in
                
                if error == SUCCESS {
                    self.imagesId.append((imageModel?.imageId)!)
                } else if !self.alertAlreadyAppeard {
                    self.alertAlreadyAppeard = true
                }
                
                if self.imagesId.count == images.count {
                    self.dismissImagePicker(imagePicker: picker)
                }
            })
        }
    }
    
    func dismissImagePicker(imagePicker: UIViewController) {
        if !alertAlreadyAppeard {
            let alertController = UIAlertController(title: SUCCESS, message: IMEGES_ADDED, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                imagePicker.dismiss(animated: true, completion: nil)
            })
            
            alertController.addAction(okAction)
            imagePicker.present(alertController, animated: true, completion: nil)
        } else {
            let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: IMAGES_NOT_ADDED)
            imagePicker.present(errorAlertController, animated: true, completion: nil)
        }
    }
    
    //MARK: LocationProtocol Function
    func setItemLocation(location: [String]) {
        itemLocation = location
    }
    
    //MARK: ImagePicker Functions
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {}

    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        var encodedImages = [String]()
        
        for image in images {
            let imageData : Data = UIImagePNGRepresentation(image)!
            let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            encodedImages.append(imageBase64)
        }
        
        self.uploadImages(images: encodedImages, picker: imagePicker)
    }

    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: OpalImagePicker Functions
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        
        var encodedImages = [String]()
        
        for image in images {
            let imageData : Data = UIImagePNGRepresentation(image)!
            let imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            encodedImages.append(imageBase64)
        }
        
        self.uploadImages(images: encodedImages, picker: picker)
    }
    
    //MARK: Buttons Actions
    @IBAction func logoutPressed(_ sender: Any) {
        Utilities.saveAndDeleteUser(model: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func selectCategoryPressed(_ sender: FancyButton) {
        
        self.addNewItem.isHidden = !self.addNewItem.isHidden
        
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
        
        self.addNewItem.isHidden = false
    }
    
    @IBAction func uploadImagePressed(_ sender: FancyButton) {
         imagePicker.imagePickerDelegate = self
         present(imagePicker, animated: true, completion: nil)
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        
        if (self.prepareInputs()) {
            self.itemsNetwork.addNewItemWith(title: self.titleText.text!,
                                             description: self.descriptionText.text!,
                                             price: Float(self.priceText.text!)!,
                                             air_conditioner: (self.acSwitch.isOn ? YES : NO),
                                             on_beach: (self.beachSwitch.isOn ? YES : NO),
                                             rooms_num: Int(self.numberOfRoomsText.text!)!,
                                             persons_num: Int(self.numberOfPersonsText.text!)!,
                                             breakfast_included: (self.breakfastSwitch.isOn ? YES : NO),
                                             lunch_included: (self.lunchSwitch.isOn ? YES : NO),
                                             dinner_included: (self.dinnerSwitch.isOn ? YES : NO),
                                             drinks_included: (self.drinksSwitch.isOn ? YES : NO),
                                             lat: Double(self.latitudeText.text!)!,
                                             lng: Double(self.longitudeText.text!)!,
                                             images: self.imagesId,
                                             poster_id: Utilities.getSavedUserId(),
                                             category_id: self.categoryId) {
                                                (baseModel, error) in
                                                
                                                if error == SUCCESS {
                                                    let errorAlertController = Utilities.showAlertWithTitle(SUCCESS, withMessage: ITEM_ADDED)
                                                    self.present(errorAlertController, animated: true, completion: nil)
                                                } else {
                                                    let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                                                    self.present(errorAlertController, animated: true, completion: nil)
                                                }
            }
        } else {
            let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: MANDATORY)
            self.present(errorAlertController, animated: true, completion: nil)
        }
    }
    
    //MARK: Navigation Segue Actions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            let mapViewController = segue.destination as! MapViewController
            mapViewController.choosenLocation = self
        }
    }
}
