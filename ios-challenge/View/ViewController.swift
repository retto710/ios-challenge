//
//  ViewController.swift
//  ios-challenge
//
//  Created by Chknchill on 1/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imgRefresh: UIImageView!
    @IBOutlet weak var txtFieldRecieveAmount: UITextField!
    @IBOutlet weak var txtFieldSentAmount: UITextField!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var recieveView: UIView!
    @IBOutlet weak var sentView: UIView!
    @IBOutlet weak var btnStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnStart.backgroundColor = UIColor.blue
        sentView.layer.borderColor = UIColor.gray.cgColor
        sentView.layer.borderWidth = 1
            sentView.layer.cornerRadius = 10
        recieveView.layer.borderColor = UIColor.gray.cgColor
        recieveView.layer.borderWidth = 1
        recieveView.layer.cornerRadius = 10
        imgRefresh.layer.cornerRadius = 3
        //tap
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(gesture)
        
        //delegates
        txtFieldSentAmount.delegate = self
        txtFieldRecieveAmount.delegate = self

        
    }
    @objc func hideKeyboard(sender : UITapGestureRecognizer) {
        // Do what you want
        self.view.endEditing(true)
        topConstraint.constant = 20
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFieldSentAmount {
            topConstraint.constant = -50
        }
        else {
            topConstraint.constant = -100
        }
        return true
    }
}

