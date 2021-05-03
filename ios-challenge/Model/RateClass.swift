//
//  RateClass.swift
//  ios-challenge
//
//  Created by Chknchill on 3/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import Foundation
import UIKit
class RateClass {
    var sell: Double
    var buy: Double
    var currencyName: String
    var image: UIImage
    
    init(_sell:Double,_buy:Double, _currencyName:String, _image:UIImage) {
        self.buy = _buy
        self.sell = _sell
        self.currencyName = _currencyName
        self.image = _image
    }
    
    init (){
        self.buy = 0
        self.sell = 0
        self.currencyName = ""
        self.image = UIImage()
    }
}
