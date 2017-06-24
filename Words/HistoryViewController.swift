//
//  HistoryViewController.swift
//  Words
//
//  Created by Александр on 22.06.17.
//  Copyright © 2017 hil. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    
    
//Initializers
var Words = [String]()
@IBOutlet weak var historyTable: UITableView!
        lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
   
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        historyTable.dataSource = self
        historyTable.delegate = self
        //Request to the Realm
        queryWords()
        self.historyTable.addSubview(self.refreshControl)
        
    }
    
    
    
    
    
    
    //TableView setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return Words.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Words[indexPath.row]
        
               return cell
    }
    
    
    //Implement refresh
    func handleRefresh(refreshControl: UIRefreshControl) {
        //Reloading data
        //self.queryWords()
        self.historyTable.reloadData()
        refreshControl.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.queryWords()
       // self.historyTable.reloadData()

    }
    
    //Query function
    func queryWords()
    {
        Words = []
        let realm = try! Realm()
        let allWordsInRealm = realm.objects(RealmWord)
        for tempWord in allWordsInRealm
        {
            Words.append(tempWord.word)
            //print("\(tempWord.word)")
            
            historyTable.reloadData()
        }
    }
}
