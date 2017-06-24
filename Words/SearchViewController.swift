//
//  SearchViewController.swift
//  Words
//
//  Created by Александр on 23.06.17.
//  Copyright © 2017 hil. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD

class SearchViewController: UIViewController {
    
    
    
    //Outlets
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var wordLabel: UILabel!
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    
    
    
    
    //Segue preparing function - TRANSFER A STRING TO the next viewcontroller
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var secondController = segue.destination as! SearchDetailViewController
        secondController.myString = searchField.text!
    }
    
    
    
    
    
    //Search button
    
    @IBAction func searchButton(_ sender: UIButton)
    {
        if searchField.text?.isEmpty ?? true {
        let alert = UIAlertController(title: "Search field is empty", message: "Enter a text and try to search again", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
            
    }
    else
    {
       print("textField has some text")
        
    }
       
       self.dismissKeyboard()
       performSegue(withIdentifier: "sBSegue", sender: self)
        
    }
    
  
}





    //Extension for hiding keyboard

    extension UIViewController
    {
        
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
        
}
