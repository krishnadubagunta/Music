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
import SwiftyJSON

class OnboardingViewController: UIViewController {
    
    var logo : UIImageView!
    
    var loginButton : Button!
    var login : IconButton!
    var signupButton : Button!
    var imageString = ""
    var name = ""
    var id = ""
    var friends : [Any]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.white
        prepareLogo()
        preparePageView()
        prepareButton()
        // Do any additional setup after loading the view.
    }

    
    @objc func configureFacebook() {
        
        Facebook.loginFacebook { (result) in
            let tabs = AppTabBarController(viewControllers: [AppNavigationController(rootViewController: MessageViewController()),TrendingViewController(),ViewController(),AppNavigationController(rootViewController: SearchViewController()),AppNavigationController(rootViewController: AccountController())])
            
            UIApplication.shared.keyWindow?.rootViewController = tabs
            
            self.navigationController?.popToRootViewController(animated: true)

        }
        
        
    }
    
    @objc func performLogin() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func performSignup() {
        navigationController?.pushViewController(SignipViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension OnboardingViewController {
    
    fileprivate func prepareLogo() {
        logo = UIImageView(image: #imageLiteral(resourceName: "logo4"))
        logo.shapePreset = .circle
        logo.depthPreset = .depth4
        view.layout(logo)
            .centerHorizontally()
            .centerVertically(offset: -50)
    }
    
    fileprivate func prepareButton() {
        
        loginButton = RaisedButton(title: "Sign up with Facebook", titleColor: Color.white)
        loginButton.backgroundColor = Color.blue.darken4
        loginButton.depthPreset = .depth4
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        loginButton.addTarget(self, action: #selector(configureFacebook), for: .touchUpInside)
        loginButton.contentScaleFactor = UIScreen.main.scale
        
        signupButton = RaisedButton(title: "Sign up with Email", titleColor: Color.blue.darken4)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        signupButton.depthPreset = .depth4
        signupButton.addTarget(self, action: #selector(performSignup), for: .touchUpInside)
        view.layout(signupButton).centerHorizontally()
                .left(50)
                .right(50)
                .height(40)
                .bottom(50)
        signupButton.contentScaleFactor = UIScreen.main.scale
        
        view.layout(loginButton).centerHorizontally()
            .left(50)
            .right(50)
            .height(40)
            .bottom(signupButton.layoutMargins.top + 100)
        
        
        login = IconButton(title: "LOGIN", titleColor: Color.blue.darken4)
        login.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        login.pulseAnimation = .none
        login.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
        navigationItem.rightViews = [login]
        
    }
    
    
    
    fileprivate func preparePageView() {
        
    }
    
}
