//
//  OnboardingViewController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/12/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON

class OnboardingViewController: UIViewController {
    
    var logo : UIImageView!
    var loginManager : LoginManager!
    var loginButton : Button!
    var login : IconButton!
    var signupButton : Button!
    var imageString = ""
    var name = ""
    var id = ""
    var friends : [Any]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginManager = LoginManager()
        prepareLogo()
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
                let graphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields" : "id,name,birthday,gender,picture,friends{id,name,picture,birthday}"], httpMethod: "GET")
                graphRequest?.start(completionHandler: { (_, resultConnection, _) in
                    
                    let json = JSON.init(resultConnection!)
                    self.imageString = try! Data.init(contentsOf: URL(string: json["picture"]["data"]["url"].string!)!).base64EncodedString()
                    self.friends = json["friends"]["data"].arrayObject
                    
                    
                    let tabs = AppTabBarController(viewControllers: [AppNavigationController(rootViewController: MessageViewController()),TrendingViewController(),ViewController(),AppNavigationController(rootViewController: SearchViewController()),AppNavigationController(rootViewController: AccountController())])

                    UIApplication.shared.keyWindow?.rootViewController = tabs

                    self.navigationController?.popToRootViewController(animated: true)
                    
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
    
    fileprivate func prepareLogo() {
        logo = UIImageView(image: #imageLiteral(resourceName: "logo3"))
        logo.shapePreset = .circle
        logo.depthPreset = .depth4
        view.layout(logo)
            .centerHorizontally()
            .top(100)
    }
    
    fileprivate func prepareButton() {
        loginButton = RaisedButton(title: "Sign up with Facebook", titleColor: Color.white)
        loginButton.backgroundColor = Color.blue.darken4
        loginButton.depthPreset = .depth4
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        loginButton.addTarget(self, action: #selector(configureFacebook), for: .touchUpInside)
        view.layout(loginButton).centerHorizontally()
                .left(40)
                .right(40)
                .height(40)
                .bottom(100)
//
        signupButton = RaisedButton(title: "Sign up with Email", titleColor: Color.blue.darken4)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        signupButton.depthPreset = .depth4
        view.layout(signupButton).centerHorizontally()
                .left(40)
                .right(40)
                .height(40)
                .bottom(50)
        
        login = IconButton(title: "LOGIN", titleColor: Color.blue.darken4)
        login.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        login.pulseAnimation = .none
        navigationItem.rightViews = [login]
        
    }
    
    
    
    fileprivate func preparePageView() {
        
    }
    
}
