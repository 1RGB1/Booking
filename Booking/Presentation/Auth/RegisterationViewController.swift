//
//  RegisterationViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/1/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit
import CoreLocation

class RegisterationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var movingScrollView: UIScrollView!
    
    @IBOutlet weak var usernameFld: FancyField!
    @IBOutlet weak var passwordFld: FancyField!
    @IBOutlet weak var emailFld: FancyField!
    @IBOutlet weak var phoneFld: FancyField!
    @IBOutlet weak var addressFld: FancyField!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var latitude: Double!
    var longitude: Double!
    var askPermForLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getCurrentLocation()
    }
    
    func getCurrentLocation() {
        if !askPermForLocation {
            self.locationAuthStatus()
        }
        
        if let currLoc = currentLocation {
            latitude = currLoc.coordinate.latitude
            longitude = currLoc.coordinate.longitude
        }
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            askPermForLocation = true
            currentLocation = locationManager.location
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == addressFld) {
            self.movingScrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        movingScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        if let username = usernameFld.text,
           let password = passwordFld.text,
           let email = emailFld.text,
           let phone = phoneFld.text,
           let address = addressFld.text {
            
            var errorAlertController: UIAlertController
            
            if (!Utilities.isValidInput(username, withRegex: USERNAME_REGEX)) {
                errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: INVALID_USERNAME)
                self.present(errorAlertController, animated: true, completion: nil)
                return
            }
            
            if (!Utilities.isValidInput(password, withRegex: PASSWORD_REGEX)) {
                errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: INVALID_PASSWORD)
                self.present(errorAlertController, animated: true, completion: nil)
                return
            }
            
            if (!Utilities.isValidInput(email, withRegex: EMAIL_REGEX)) {
                errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: INVALID_EMAIL)
                self.present(errorAlertController, animated: true, completion: nil)
                return
            }
            
            if (!Utilities.isValidInput(phone, withRegex: PHONE_REGEX)) {
                errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: INVALID_PHONE)
                self.present(errorAlertController, animated: true, completion: nil)
                return
            }
            
            let authenticationNetwork = AuthenticationNetwork()
            authenticationNetwork.registerWith(username: username, password: password, email: email, phone: phone, address: address, latitutde: latitude, longitude: longitude, completionHandler: {
                (baseModel, error) in
                
                if error == SUCCESS {
                    
                    authenticationNetwork.loginWith(email: email, password: password, completionHandler: {
                        (userModel, errorLogin) in
                        
                        if errorLogin == SUCCESS {
                            Utilities.saveAndDeleteUser(model: userModel)
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                            self.present(homeViewController, animated: true, completion: nil)
                        }
                    })
                } else {
                    let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            })
        }
    }
}
