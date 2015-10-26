//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by James Pacheco on 10/15/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    var entry: Entry?
    @IBOutlet var keyboardToolbar: UIToolbar!
    @IBOutlet var detailView: UIView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyTextField.inputAccessoryView = keyboardToolbar
        if navItem.title != "Edit Entry" {
            navItem.title = "New Entry"
        } 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func  updateWithEntry(entry: Entry) {
        self.entry = entry
        titleTextField.text = entry.title
        bodyTextField.text = entry.body
        detailView.backgroundColor = entry.randomColor
        navItem.title = "Edit Entry"
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func saveEntry(sender: AnyObject) {
        if titleTextField.text == "" || titleTextField.text == "Sample title" {
            let noTitleAlert = UIAlertController(title: "Please add a title", message: "", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            noTitleAlert.addAction(alertAction)
            presentViewController(noTitleAlert, animated: true, completion: nil)
        } else {
            if let entry = self.entry {
                entry.title = self.titleTextField.text!
                entry.body = self.bodyTextField.text
                entry.timeStamp = NSDate()
            } else {
                let time = NSDate()
                let newEntry = Entry(timeStamp: time, title: self.titleTextField.text!, body: self.bodyTextField.text)
                EntryController.sharedController.addEntry(newEntry)
                self.entry = newEntry
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func clearEntry(sender: AnyObject) {
        titleTextField.text = ""
        bodyTextField.text = ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func keyboardDoneButtonPressed(sender: AnyObject) {
        bodyTextField.resignFirstResponder()
    }

}
