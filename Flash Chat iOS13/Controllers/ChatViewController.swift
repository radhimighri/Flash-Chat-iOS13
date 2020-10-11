//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Radhi Mighri on 21/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    //    var messages: [Message] = [
    //        Message(sender: "1@2.com", body: "Hey !"),
    //        Message(sender: "a@b.com", body: "Hello !"),
    //        Message(sender: "1@2.com", body: "What's up ?")
    //
    //    ]
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        //add a title on the navigation bar
        title =  K.appName
        
        // hide the back button from our navigation bar
        navigationItem.hidesBackButton = true
        
        // register the MessageCell xib(nib) with my tableView
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
    }
    
    func loadMessages() {
        
        
        //        db.collection(K.FStore.collectionName).getDocuments { (querySnapshot, error) in
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in //every time there is a new message added (change in our DB) the "addSnapshotListner" will trigger automatically this closure below wich empties out our messages array and adds all of the new messages back in to that messages array

            self.messages = [] //add every new data in an empty Array without having all of the previous messages being added alongside


            if let e = error {
                print("There was an issue retrieving data from Firestore, \(e)")
            }else {
                if let snapShotDocument = querySnapshot?.documents{
                    for doc in snapShotDocument {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData() // reloadData() trigger the two delegate methods of tableView and put the cells into our table view
                                
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0) // wich line we gonna scroll to (in our case we want the last added cell (row) we put "-1" to avoid "the Index out of range") , sectiion 0 : because we have only one section
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (err) in
                if let e = err {
                    print("There was an issue saving data to Firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    //when we are inside an "closure" and we want to update the User Interface we should always use "DispatchQueue.main.async" method
                    DispatchQueue.main.async {
                        self.messageTextfield.text = "" // so this happens on the main thread rather than on a background thread wich is where the code in closures tend to take place 

                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            //navigate to the root controller
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
}


extension ChatViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    
    // this func will be called for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell // we use as! to cast this reusable cell as a MessageCell class
        cell.label.text = message.body

        if message.sender == Auth.auth().currentUser?.email{ // this is a message from the current user
            cell.leftImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }else { // this is a message from the another sender.
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
            
        }
    
     return cell
    
}

}
