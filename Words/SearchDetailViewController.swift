//
//  SearchDetailViewController.swift
//  Words
//
//  Created by Александр on 23.06.17.
//  Copyright © 2017 hil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation
import CoreData
import MBProgressHUD
import RealmSwift




class SearchDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    
    //Initializers
    @IBOutlet weak var tableArray: UITableView!
    @IBOutlet weak var wordTitle: UILabel!
    @IBOutlet weak var wordController: UISegmentedControl!
    var words: [Word] = []
    var word: String!
    var finalNounArray: Array<String> = []
    var finalVerbArray: Array<String> = []
    var serv = Server()
    var results: JSON!
    var searchFirst = SearchViewController()
    var myString = String()
   
    
    
    
    
    
    override func viewDidLoad()
        
    {
        super.viewDidLoad()
        
        //TableView delegate and data source
        tableArray.dataSource = self
        tableArray.delegate = self
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:
            {
                loadingNotification.hide(animated: true)
        })
        
    }
    
   
    
    
    
    
    
    
    //TableView setup - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnValue = 0
        //switch (selected control)
        switch (wordController.selectedSegmentIndex)
        {
        case 0:
            returnValue = finalNounArray.count
            break
        case 1:
            returnValue = finalVerbArray.count
        default:
            break
        }
        return returnValue
    }
    
    
    
    
    
    
    
    //TableView setup - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        
        //switch (selected control)
        
        switch (wordController.selectedSegmentIndex)
        {
        case 0:
            var tempNoun = finalNounArray[indexPath.row]
            cell.textLabel?.text = tempNoun
            break
        case 1:
            var tempVerb = finalVerbArray[indexPath.row]
            cell.textLabel?.text = tempVerb
            break
        default:
            break
        }
        return cell
    }
    
    
    
    
    
    
    
    
    //Selected control button
    @IBAction func buttonWordPressed(_ sender: UISegmentedControl)
    {
        self.tableArray.reloadData()
    }

    
    
    
    
    
    
   //Add word to database function
    
    func addWord()
    {
        //Creating a RealmWord object
        let tempWord = RealmWord()
        
        //Word name change in Realm object
        tempWord.word = self.myString
        
        //Creating a Realm object
        let realmBase = try! Realm()
        
        //Start writing
        try! realmBase.write
        {
            
            //Writing a word name
            realmBase.add(tempWord)
            
//            //Printing (first part of object saved)
//            print("1st part of object \(tempWord.word) saved")
//            
//            //Creating a temporary array
//            let tempNounRealmArrayElements = finalNounArray
//            
//            //Create a loop to create an array
//            for element in tempNounRealmArrayElements
//            {
//                let tempArrayElement = NounArrayElement()
//                tempArrayElement.arrayElement = element
//                realmBase.add(tempArrayElement)
//            }
//            
//            //Creating a temp array
//            var categories: Results<NounArrayElement> = { realmBase.objects(NounArrayElement.self) }()
//            
//            //Change a value of array
//            categories = realmBase.objects(NounArrayElement.self)
//            
//            //Print
//            print(categories)
            
        }
        
    }
    
    
    //Button for word saving
    @IBAction func saveButton(_ sender: UIButton)
    {
         //Add word to the Realm
        self.addWord()
        
        //Success alert
        let alert = UIAlertController(title: "Saved", message: "Word '\(self.myString)' is in the history now", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        //Creating a request
        self.serv.searchWord(word: myString)
        
        //Костыль для того, чтобы данные успели загрузиться
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:
        {
            //Loading a JSON
            self.results = self.serv.jsonData
            
            //Print JSON Results
            print(self.results)
            
            //Creating an Arrays
            self.finalNounArray = self.results["noun"]["syn"].arrayObject! as! Array<String>
            self.finalVerbArray = self.results["verb"]["syn"].arrayObject! as! Array<String>
            
            //Reloading data
            self.tableArray.reloadData()
            
            //Printing an array
            print(self.finalNounArray)
            
                
                
    })
        
        
             //Reloading table view again
             self.tableArray.reloadData()
        
             self.wordTitle.text = self.myString
        
    }

}
