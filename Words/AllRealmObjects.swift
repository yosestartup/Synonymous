//
//  File.swift
//  Words
//
//  Created by Александр on 24.06.17.
//  Copyright © 2017 hil. All rights reserved.
//

import Foundation
import RealmSwift


class RealmWord: Object
{
    dynamic var word = ""
    //lazy var nouns = Results<NounArrayElement>()
  //  lazy var categories: Results<Category> = { self.realm.objects(Category) }()
}

