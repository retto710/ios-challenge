//
//  CurrencyListViewController.swift
//  ios-challenge
//
//  Created by Chknchill on 3/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import UIKit
import CoreData
class CurrencyListViewController: UIViewController {
    @IBOutlet weak var tblViewListCurrency: UITableView!
    var currentRates: [RateClass] = []
    var baseCUrrencyName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Second screen!")
        getRates()
    }
    
    func exampleData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Rate", in: context)
        let rateObject = NSManagedObject(entity: entity!, insertInto: context)
        //classes
        let imgData = UIImage(named: "euro")!.pngData()
        rateObject.setValue(Double.random(min: 0.00, max: 3.6), forKey: "sell")
        rateObject.setValue(imgData, forKey: "image")
        rateObject.setValue("Soles", forKey: "currencyName")
        rateObject.setValue(Double.random(min: 0.00, max: 3.3), forKey: "buy")
        rateObject.setValue("Euros", forKey: "baseCurrencyName")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getRates(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Rate")
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "baseCurrencyName = %@", baseCUrrencyName!)
        request.predicate = predicate
        exampleData()
        do {
            let result = try context.fetch(request)
            if(result.isEmpty){
                exampleData()
            }
            for data in result as! [NSManagedObject] {
                var image: UIImage = UIImage()
                if let imageData = data.value(forKey: "image") as? NSData {
                    image = (UIImage(data:imageData as Data)) ?? UIImage(named: "euro")!
                }
                let temp = RateClass(_sell: data.value(forKey: "sell") as! Double, _buy: data.value(forKey: "buy") as! Double, _currencyName: data.value(forKey: "currencyName") as! String, _image: image, _baseCurrencyName: data.value(forKey: "baseCurrencyName") as! String )
                currentRates.append(temp)
            }
            
        } catch {
            
            print("Failed")
        }
    }
}

extension CurrencyListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateTableViewCell") as! RateTableViewCell
        cell.setRate(rate: currentRates[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ChangeRate", in: context)
        let rateObject = NSManagedObject(entity: entity!, insertInto: context)
        //classes
        rateObject.setValue(currentRates[indexPath.row].sell, forKey: "sell")
        rateObject.setValue(currentRates[indexPath.row].buy, forKey: "buy")
        rateObject.setValue(currentRates[indexPath.row].currencyName, forKey: "newCurrency")
        rateObject.setValue(currentRates[indexPath.row].baseCurrencyName, forKey: "previousCurrency")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}

public extension Double {

    static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}
