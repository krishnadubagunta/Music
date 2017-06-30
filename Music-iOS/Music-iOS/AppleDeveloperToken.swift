//
//  AppleDeveloperTokenGeneration.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/24/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import JWT
//import Obfuscator


struct API_KEYS {
    static let AppleKey_Dev = [21, 8, 77, 50, 62, 84, 108, 92, 22, 107] as [UInt8]
    static let Appledevkey = [31, 27, 57, 65, 48, 59, 10, 94, 7, 30] as [UInt8]
}

class AppleDeveloperToken {
    
    fileprivate var claims : ClaimSet!
    static var token : String!
    let obfData = Obfuscator(withSalt: [SongsViewController.self, AppDelegate.self,UINavigationController.self])
    
}

extension AppleDeveloperToken {
    
    func printBytes() {
    }
    
    fileprivate func generateToken() {
        claims = ClaimSet()
        claims.issuer = obfData.reveal(key: API_KEYS.AppleKey_Dev)
        claims.issuedAt = Date()
        claims.expiration = DateInterval.init(start: Date(), duration: TimeInterval(15777000)).end
        
        let token = JWT.encode(claims: claims, algorithm: .hs256(obfData.reveal(key: API_KEYS.Appledevkey).data(using: .utf8)!))
        
    }
    
}
