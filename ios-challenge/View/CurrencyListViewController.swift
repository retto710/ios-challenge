//
//  CurrencyListViewController.swift
//  ios-challenge
//
//  Created by Chknchill on 3/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import UIKit
import CoreData
class CurrencyListViewController: UIViewController, UITableViewDelegate {

    

    @IBOutlet weak var tblViewListCurrency: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let example: [String] = ["a","b","c"]
        tblViewListCurrency.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func exampleData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CurrencyExchange", in: context)
        let currencyExchange = NSManagedObject(entity: entity!, insertInto: context)
        //classes
        let sol1 = RateClass(_sell: 3.6, _buy: 3.8, _currencyName: "Soles", _image: UIImage(named: "peru")!)
        let sol2 = RateClass(_sell: 3.6, _buy: 3.8, _currencyName: "dol aus", _image: UIImage(named: "australia")!)
        let sol3 = RateClass(_sell: 3.6, _buy: 3.8, _currencyName: "Euro", _image: UIImage(named: "euro")!)
        let sol4 = RateClass(_sell: 3.6, _buy: 3.8, _currencyName: "Dolares", _image: UIImage(named: "usa")!)
        let ratesSol: Array<RateClass> = [sol1,sol2,sol3,sol4]
        
        currencyExchange.setValue(ratesSol, forKey: "rates")
        currencyExchange.setValue(UUID(), forKey: "id")
        currencyExchange.setValue(Date(), forKey: "date")
        currencyExchange.setValue("Soles", forKey: "base")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
