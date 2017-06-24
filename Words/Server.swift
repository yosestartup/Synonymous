//
//  Server.swift
//  Words
//
//  Created by Александр on 22.06.17.
//  Copyright © 2017 hil. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON





class Server
{
    var wordFinal: String?
    var nounSyn: Array<Any>!
    var verbSyn: Array<Any>!
    var result: String?

    //    var icon: UIImage?

   
    
    var jsons: DataResponse<Any>?
    var jsonData: JSON!
    
    func searchWord (word: String)
    {
        
        let params = ["1" : "1"]
        setRequest(params: params as [String : AnyObject], word: word)
        
    }
    
   
    
    func setRequest(params: [String: AnyObject], word: String)
    {
        let api = "3368db3bb975b3a3afd441874c2b5c1a"
        
         var urld = URL(string: "http://words.bighugelabs.com/api/2/\(api)/\(word)/json")
        
        Alamofire.request(urld!, method: .get, parameters: params).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.wordFinal = word
                var tempNounSynArray = json["noun"]["syn"].arrayObject
                self.nounSyn = tempNounSynArray
                self.verbSyn = json["verb"]["syn"].arrayObject
                self.jsonData = json
                DispatchQueue.main.async
                    
                {
                    
                }
                
            case .failure:
                print("shit")
                
                
            }
        }
        
        
        
    }
    
    
    
 
    
    

}
