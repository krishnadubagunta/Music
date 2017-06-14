//
//  User.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/12/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var picture = ""
    var friends = List<User>()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
