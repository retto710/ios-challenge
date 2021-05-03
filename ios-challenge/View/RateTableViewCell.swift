//
//  RateTableViewCell.swift
//  ios-challenge
//
//  Created by Chknchill on 3/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCurrencyName: UILabel!
    @IBOutlet weak var imgRateFlag: UIImageView!
    @IBOutlet weak var lblCurrencyRate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setRate(rate: RateClass){
        lblCurrencyName.text = rate.currencyName
        imgRateFlag.image = rate.image
        lblCurrencyRate.text = "1 = " + String(format: "%.3f", rate.buy)
        
    }

}
