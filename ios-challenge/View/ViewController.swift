//
//  ViewController.swift
//  ios-challenge
//
//  Created by Chknchill on 1/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var viewRecieveCurrency: UIView!
    @IBOutlet weak var viewSentCurrency: UIView!
    @IBOutlet weak var lblCurrencyRate: UILabel!
    @IBOutlet weak var lblRecieveCurrency: UILabel!
    @IBOutlet weak var lblSentCurrency: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var txtFieldRecieveAmount: UITextField!
    @IBOutlet weak var txtFieldSentAmount: UITextField!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var recieveView: UIView!
    @IBOutlet weak var sentView: UIView!
    @IBOutlet weak var btnStart: UIButton!
    
    var currentExchan: CurrentExchangeClass = CurrentExchangeClass()
    var currentTransaction: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //init vars
        btnStart.backgroundColor = UIColor.blue
        sentView.layer.borderColor = UIColor.gray.cgColor
        sentView.layer.borderWidth = 1
        sentView.layer.cornerRadius = 10
        recieveView.layer.borderColor = UIColor.gray.cgColor
        recieveView.layer.borderWidth = 1
        recieveView.layer.cornerRadius = 10
        btnChange.layer.cornerRadius = 10
        //tap
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(gesture)
        let gesturePress = UILongPressGestureRecognizer(target: self, action:  #selector(self.goToListView))
        let gesturePress2 = UILongPressGestureRecognizer(target: self, action:  #selector(self.goToListView))
        gesturePress.minimumPressDuration = 3.0 // 1 second press
        gesturePress.delaysTouchesBegan = true
        gesturePress.delegate = self
        gesturePress2.minimumPressDuration = 3.0 // 1 second press
        gesturePress2.delaysTouchesBegan = true
        gesturePress2.delegate = self
        viewSentCurrency.addGestureRecognizer(gesturePress2)
        viewRecieveCurrency.addGestureRecognizer(gesturePress)
        //delegates
        txtFieldSentAmount.delegate = self
        txtFieldRecieveAmount.delegate = self
        getActualExchange()
        //
        
        
    }
    
    func setExchangeValues(){
        //set values
        lblRecieveCurrency.text = currentExchan.baseCurrencyName
        lblSentCurrency.text = currentExchan.destinationCurrencyName
        lblCurrencyRate.text = "Compra: " + String(format: "%.3f", currentExchan.buy/currentExchan.destinationBuy) + " Venta: " + String(format: "%.3f", currentExchan.sell/currentExchan.destinationSell)
    }
    
    func changeActualExchange(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrExchange")
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                results![0].setValue(currentExchan.buy, forKey: "buy")
                results![0].setValue(currentExchan.baseCurrencyName, forKey: "baseCurrencyName")
                results![0].setValue(currentExchan.sell, forKey: "sell")
                results![0].setValue(currentExchan.destinationCurrencyName, forKey: "destinationCurrencyName")
                results![0].setValue(currentExchan.destinationBuy, forKey: "destinationBuy")
                results![0].setValue(currentExchan.destinationSell, forKey: "destinationSell")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
            setExchangeValues()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    @IBAction func onClickInvertCurrency(_ sender: Any) {
        var temp: String
        var temp2: Double
        var tempSell: Double
        temp = currentExchan.baseCurrencyName
        temp2 = currentExchan.buy
        tempSell = currentExchan.sell
        currentExchan.baseCurrencyName = currentExchan.destinationCurrencyName
        currentExchan.destinationCurrencyName = temp
        currentExchan.buy = currentExchan.destinationSell
        currentExchan.sell = currentExchan.destinationBuy
        currentExchan.destinationBuy = tempSell
        currentExchan.destinationSell = temp2
        changeActualExchange()
    }
    @objc func hideKeyboard(sender : UITapGestureRecognizer) {
        self.view.endEditing(true)
        topConstraint.constant = 20
    }

    @objc func goToListView(sender : UITapGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let listViewController = storyBoard.instantiateViewController(withIdentifier: "CurrencyListViewController") as! CurrencyListViewController

            self.navigationController?.pushViewController(listViewController, animated: true)
        }
        else {
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFieldSentAmount {
            currentTransaction = 0
            topConstraint.constant = -50
        }
        else {
            currentTransaction = 1
            topConstraint.constant = -100
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtFieldSentAmount && currentTransaction == 0 {
            if let number = Double(textField.text!) {
                txtFieldRecieveAmount.text = String(format: "%.3f", number * currentExchan.buy/currentExchan.destinationBuy)
            } else {
                let dialogMessage = UIAlertController(title: "Error", message: "Monto de envio no valido", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default)
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
        else if textField == txtFieldRecieveAmount && currentTransaction == 1 {
            if let cost = Double(textField.text!) {
                txtFieldSentAmount.text = String(format: "%.3f", cost / (currentExchan.sell/currentExchan.destinationSell))
            } else {
                let dialogMessage = UIAlertController(title: "Error", message: "Monto de recibido no valido", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default)
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    //data
    func loadFirstExchange(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CurrExchange", in: context)
        let currentExchange = NSManagedObject(entity: entity!, insertInto: context)
        currentExchange.setValue("Soles", forKey: "baseCurrencyName")
        currentExchange.setValue("Dolares", forKey: "destinationCurrencyName")
        currentExchange.setValue(3.29, forKey: "sell")
        currentExchange.setValue(3.25, forKey: "buy")
        currentExchange.setValue(1, forKey: "destinationBuy")
        currentExchange.setValue(1, forKey: "destinationSell")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func getActualExchange(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrExchange")
        request.returnsObjectsAsFaults = false
        
        if currentExchan.baseCurrencyName = "" {
            loadFirstExchange()
        }
        do {
            let result = try context.fetch(request)
            if(result.isEmpty){
                        loadFirstExchange()
            }
            for data in result as! [NSManagedObject] {
                currentExchan = CurrentExchangeClass(_sell: data.value(forKey: "sell") as! Double, _buy: data.value(forKey: "buy") as! Double, _baseCurrencyName: data.value(forKey: "baseCurrencyName") as! String, _destinationCurrencyName: data.value(forKey: "destinationCurrencyName") as! String, _destinationSell: data.value(forKey: "destinationSell") as! Double, _destinationBuy: data.value(forKey: "destinationBuy") as! Double)
                print(currentExchan)
            }
            setExchangeValues()
            
        } catch {
            
            print("Failed")
        }
    }
}

