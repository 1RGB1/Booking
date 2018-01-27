//
//  LoginViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/1/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: TextFields Outlets
    @IBOutlet weak var emailFld: FancyField!
    @IBOutlet weak var passwordFld: FancyField!
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: TextFieldDelegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    //MARK: Buttons Actions
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if let email = emailFld.text, let password = passwordFld.text {
            
            var alertController: UIAlertController
            
            if (!Utilities.isValidInput(email, withRegex: EMAIL_REGEX)) {
                
                alertController = Utilities.showAlertWithTitle(ERROR, withMessage: INVALID_EMAIL)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            if (!Utilities.isValidInput(password, withRegex: PASSWORD_REGEX)) {
                alertController = Utilities.showAlertWithTitle(ERROR, withMessage: INVALID_PASSWORD)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            let authenticationNetwork = AuthenticationNetwork()
            authenticationNetwork.loginWith(email: email, password: password, completionHandler: {
                (usermodel, error) in
                
                if error == SUCCESS {
                    Utilities.saveAndDeleteUser(model: usermodel)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                    self.present(homeViewController, animated: true, completion: nil)
                } else {
                    let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            })
        }
    }
}
