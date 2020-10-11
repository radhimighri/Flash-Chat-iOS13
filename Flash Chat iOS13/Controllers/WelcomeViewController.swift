//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Radhi Mighri on 21/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    // Before showing the welcome screen
    override func viewWillAppear(_ animated: Bool) {
    // one of the best practices always when we override the lifecycle methods we have to call "super" like the viewDidLoad() : see apple doc for more details
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // When we're about to go into the next screen (click "login" or "register" button)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* Before using "CLTypingLabel" pod
         
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "⚡️FlashChat"
        for letter in titleText{
            print(charIndex * 0.1)
            print(letter)
            print("**********")
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
      */
        
        // By using CLTypingLabel : now we're able to achieve the same result just by using one line of code
        
        titleLabel.text = K.appName
       
    }
        
        
    

}
