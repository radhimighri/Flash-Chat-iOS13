//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Radhi Mighri on 21/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    override func viewDidLoad() {
        title =  K.appName
        
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        // Optional Binding & Optional chaining
        if let email = emailTextfield.text ,let password = passwordTextfield.text { //if email and pwd aren't nil then create the user
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //print(e)
                    print(e.localizedDescription) //show the error in your iphone setted language in a short and clear description
              
                    let alert = UIAlertController(title: "Alert", message: e.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                } else {
                    // Navigate to the ChatViewController
                    //before using constants and static
                    //                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                    //after using constants and static
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)

                }
            }
            
        }
        
    }
    
}
