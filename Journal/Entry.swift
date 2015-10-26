//
//  Entry.swift
//  Journal
//
//  Created by James Pacheco on 10/15/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit
import Foundation

class Entry: Equatable {
    
    static let timeStampKey = "timeStampKey"
    static let titleKey = "titleKey"
    static let bodyKey = "bodyKey"
//    static let colorKey = "colorKey"
    
    let randomColor: UIColor = UIColor(red: CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max), green: CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max), blue: CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max), alpha: 1.0)
    var timeStamp: NSDate
    var title: String
    var body: String
    
    init(timeStamp: NSDate, title: String, body: String){
        self.timeStamp = timeStamp
        self.title = title
        self.body = body
    }
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let timeStamp = dictionary[Entry.timeStampKey] as? NSDate,
                      title = dictionary[Entry.titleKey] as? String,
                       body = dictionary[Entry.bodyKey] as? String else {
                
                self.timeStamp = NSDate()
                self.title = ""
                self.body = ""
                        return nil
                        
        }
        
        self.timeStamp = timeStamp
        self.title = title
        self.body = body
        
    }
    
    func dictionaryCopy() -> [String: AnyObject] {
        let dictionary: Dictionary <String, AnyObject> = [
            Entry.timeStampKey: timeStamp,
            Entry.titleKey: title,
            Entry.bodyKey: body,
//            Entry.colorKey: randomColor
        ]
        return dictionary
    }
    
}

func == (lhs: Entry, rhs: Entry) -> Bool {
    return ((lhs.title == rhs.title) && (lhs.timeStamp == rhs.timeStamp) && (lhs.body == rhs.body))
}