//
//  RateClass.swift
//  ios-challenge
//
//  Created by Chknchill on 3/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import Foundation
import UIKit
public class RateClass: NSObject {
    var sell: Double
    var buy: Double
    var currencyName: String
    var image: UIImage
    var baseCurrencyName:String
    
    init(_sell:Double,_buy:Double, _currencyName:String, _image:UIImage, _baseCurrencyName: String) {
        self.buy = _buy
        self.sell = _sell
        self.currencyName = _currencyName
        self.image = _image
        self.baseCurrencyName = _baseCurrencyName
    }
    
    override init (){
        self.buy = 0
        self.sell = 0
        self.currencyName = ""
        self.image = UIImage()
        self.baseCurrencyName = ""
    }
}
