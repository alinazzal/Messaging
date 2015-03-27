//
//  MessagingController.swift
//  Messaging
//
//  Created by Ali Nazzal on 3/23/15.
//  Copyright (c) 2015 Ali Nazzal. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

class MessagingController: UIViewController, SINMessageClientDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    var messageService: SINOutgoingMessage?
    var userId: String?
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        client().messageClient().delegate = self
//    }
    
//    func client() -> SINClient! {
//        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        return appDelegate.client!
//    }
    
    @IBAction func sendMessage(sender: UIButton) {
        if (!messageTextField.text.isEmpty) {
            println(userId!)
            appDelegate.sendTheMessage(messageTextField.text, recipientID: userId!)
        }
    }
    
    func messageDelivered(info: SINMessageDeliveryInfo!) {
        println(info.messageId)
    }
    
    func messageFailed(message: SINMessage!, info messageFailureInfo: SINMessageFailureInfo!) {
        println("Message failed to send")
    }
    
    func messageSent(message: SINMessage!, recipientId: String!) {
        println("MESSAGE DELIVERED")
    }
    
    func messageClient(messageClient: SINMessageClient!, didReceiveIncomingMessage message: SINMessage!) {
        println("WHOOO")
    }
    
}
