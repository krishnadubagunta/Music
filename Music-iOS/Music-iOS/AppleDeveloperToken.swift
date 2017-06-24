//
//  AppleDeveloperTokenGeneration.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/24/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import JWT



class AppleDeveloperToken {
    
    fileprivate var claims : ClaimSet!
    static var token : String!
    
}

extension AppleDeveloperToken {
    
    fileprivate func generateToken() {
        claims = ClaimSet()
        
    }
    
}
