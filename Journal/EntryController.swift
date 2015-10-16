//
//  EntryController.swift
//  Journal
//
//  Created by James Pacheco on 10/15/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class EntryController {
    
    private let entriesKey = "entries"
    
    static let sharedController: EntryController = EntryController()
    
    var entries: [Entry]
    
    init() {
        self.entries = []
        self.loadFromPersistentStorage()
        }
    
    func addEntry(entry: Entry) -> (){
        entries.append(entry)
        self.saveToPersistentStorage()
    }
    
    func removeEntry(entry: Entry) -> (){
        let index = self.entries.indexOf(entry)
        if let entryIndex = index {
            entries.removeAtIndex(entryIndex)
        }
        self.saveToPersistentStorage()
    }
    
    func loadFromPersistentStorage() {
        let entryDictionariesFromDefaults = NSUserDefaults.standardUserDefaults().objectForKey(entriesKey) as? [Dictionary<String, AnyObject>]
        
        if let entryDictionaries = entryDictionariesFromDefaults {
            self.entries = entryDictionaries.map({Entry(dictionary: $0)!})
        }
    }
    
    func saveToPersistentStorage() {
        let entryDictionaries = self.entries.map({$0.dictionaryCopy()})
        NSUserDefaults.standardUserDefaults().setObject(entryDictionaries, forKey: entriesKey)
    }
}

