//
//  User.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/12/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON
import RealmSwift

class User : Object, JSONDecodable {
    dynamic var id = ""
    dynamic var picture = ""
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var email = ""
    dynamic var token = ""
    var friends = List<User>()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(json: JSON) {
        self.init()
        print(json)
        id = json["id"].stringValue
        token = json["token"].stringValue
        firstName = json["fName"].stringValue
        lastName = json["lName"].stringValue
        email = json["email"].stringValue
        picture = json["pPicture"].stringValue
    }
    
}
