//
//  MessagaCell.swift
//  Flash Chat iOS13
//
//  Created by Radhi Mighri on 5/27/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    // a Nib is an old name of the xib
    override func awakeFromNib() { // this func is similar to the sort ot the viewDidLoad() of a ViewController, it will be called when we create a new message cell from the "MessageCell.xib"
        super.awakeFromNib()
        // Initialization code
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
