//
//  OnboardingViewController.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/12/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material
import FacebookLogin
import FBSDKCoreKit
import SwiftyJSON

class OnboardingViewController: UIViewController {
    
    var loginManager : LoginManager!
    var loginButton : Button!
    var imageString = ""
    var name = ""
    var id = ""
    var friends : [Any]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginManager = LoginManager()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        preparePageView()
        prepareButton()
        // Do any additional setup after loading the view.
    }

    
    @objc func configureFacebook() {
        loginManager.logIn([.email,.publicProfile,.userFriends, .custom("user_birthday"),.custom("user_photos")], viewController: self) { (result) in
            switch result {
            case .cancelled:
                break
            case .failed(let error) :
                print(error)
                break
            case .success(grantedPermissions: _, declinedPermissions:  _, token: _) :
                let graphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields" : "id,name,birthday,picture,friends{id,name,picture,birthday}"], httpMethod: "GET")
                graphRequest?.start(completionHandler: { (connection, resultConnection, error) in
                    connection?.cancel()
                    let json = JSON.init(resultConnection!)
                    self.imageString = try! Data.init(contentsOf: URL(string: json["picture"]["data"]["url"].string!)!).base64EncodedString()
                    self.friends = json["friends"]["data"].arrayObject
                    
                })
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension OnboardingViewController {
    
    fileprivate func prepareButton() {
            loginButton = Button(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            loginButton.backgroundColor = Color.blue
            loginButton.title = "Login with Facebook"
            view.layout(loginButton).centerHorizontally()
                .bottom(50)
                .left(40)
                .right(40)
            loginButton.addTarget(self, action: #selector(configureFacebook), for: .touchUpInside)
    }
    
    fileprivate func preparePageView() {
        
    }
    
}
