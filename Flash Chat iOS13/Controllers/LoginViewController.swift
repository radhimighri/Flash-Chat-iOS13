//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Radhi Mighri on 21/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        title =  K.appName
         
     }
     
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {

        // Optional Binding & Optional chaining/Users/radhi-mighri/Documents/R@dIOS/Section 11--15/Flash-Chat-iOS13/Pods/Pods.xcodeproj
        if let email = emailTextfield.text ,let password = passwordTextfield.text { //if email and pwd aren't nil then try to login user
        Auth.auth().signIn(withEmail: email, password: password) { /*[weak self]*/ authResult, error in
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
                  //                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                  //after using constants and static
                  self.performSegue(withIdentifier: K.loginSegue, sender: self)
              }
//          guard let strongSelf = self else { return }
        }
            
        }
        
    }
    
}
