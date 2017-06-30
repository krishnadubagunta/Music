//
//  APIError.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/29/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//


import TRON
import SwiftyJSON

class APIError : JSONDecodable {
    var errors: [String:[String]] = [:]
    
    required init(json: JSON) {
        print(json)
        if let dictionary = json["errors"].dictionary {
            for (key,value) in dictionary {
                errors[key] = value.arrayValue.map( { return $0.stringValue } )
            }
        }
    }
}

