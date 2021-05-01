//
//  DataManager.swift
//  ios-challenge
//
//  Created by Chknchill on 1/05/21.
//  Copyright © 2021 Antonhy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataManager{
    static let shared = DataManager(moc: NSManagedObjectContext.current)
    
    var context : NSManagedObjectContext
    
    private init (moc: NSManagedObjectContext){
        self.context = moc
    }
    
    //get currency

}

extension NSManagedObjectContext{
    static var current :NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
