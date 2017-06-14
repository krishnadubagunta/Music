//
//  OnboardingViewController.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/12/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit

class OnboardingViewController: UIViewController {
    
    var loginButton : LoginManager!
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        print("\n      \(result)" )
        
//        let realm = ViewController.realm!
//        
//        try! realm.write {
//            realm.create(User.self, value: ["id": result], update: <#T##Bool#>)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton = LoginManager()
        loginButton.logIn([.email,.publicProfile,.userFriends], viewController: self) { (result) in
            switch result {
            case .cancelled :
                break
            case .failed(let error) :
                
                break
            case .success(grantedPermissions: let permission, declinedPermissions: let declined, token: let aToken) :
                
                break
            }
        }
        // Do any additional setup after loading the view.
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
