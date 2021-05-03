//
//  CurrencyExchangeClass.swift
//  ios-challenge
//
//  Created by Chknchill on 1/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import Foundation


class CurrencyExchangeClass{
    var rates: Array<RateClass>
    var id: UUID
    var date: Date
    var base: String
    
    init(_rates:Array<RateClass>,_id:UUID, _date:Date, _base:String) {
        self.rates = _rates
        self.id = _id
        self.date = _date
        self.base = _base
    }
    
    init (){
        self.rates = Array<RateClass>()
        self.id = UUID.init()
        self.date = Date()
        self.base = ""
    }
}
