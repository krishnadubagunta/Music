//
//  Facebook.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/22/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import FacebookLogin
import FBSDKCoreKit
import SwiftyJSON

class Facebook {
    
    var imageString = ""
    var name = ""
    var id = ""
    var friends =  [Any]()
    
    public static func loginFacebook(completion : @escaping (_ result : JSON) -> Void) {
        
        let loginManaager = LoginManager()

        loginManaager.logIn([.email,.publicProfile,.userFriends, .custom("user_birthday"),.custom("user_photos")], viewController: nil) { (result) in
            switch result {
            case .cancelled:
                break
            case .failed(let error) :
                print(error)
                break
            case .success(grantedPermissions: _, declinedPermissions:  _, token: _) :
                let graphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields" : "id,name,birthday,gender,picture,friends{id,name,picture,birthday}"], httpMethod: "GET")
                graphRequest?.start(completionHandler: { (_, resultConnection, _) in
                    let json = JSON.init(resultConnection!)
                    completion(json)
                })
                break
            }
        }
    }
    
}
