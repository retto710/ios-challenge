//
//  CurrentExchangeClass.swift
//  ios-challenge
//
//  Created by Chknchill on 3/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import Foundation

class CurrentExchangeClass {
    var sell: Double
    var buy: Double
    var destinationSell: Double
    var destinationBuy: Double
    var baseCurrencyName: String
    var destinationCurrencyName: String
    
    init(_sell:Double,_buy:Double, _baseCurrencyName:String, _destinationCurrencyName:String,
         _destinationSell: Double,
         _destinationBuy: Double) {
        self.buy = _buy
        self.sell = _sell
        self.baseCurrencyName = _baseCurrencyName
        self.destinationCurrencyName = _destinationCurrencyName
        self.destinationBuy = _destinationBuy
        self.destinationSell = _destinationSell
    }
    
    init (){
        self.buy = 0
        self.sell = 0
        self.destinationCurrencyName = ""
        self.baseCurrencyName = ""
        self.destinationBuy = 0
        self.destinationSell = 0
    }
}
