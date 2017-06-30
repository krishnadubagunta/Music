//
//  LoginViewController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/22/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material
import FBSDKCoreKit
import FacebookLogin
import SwiftyJSON

class LoginViewController: UIViewController {

    var imageString = ""
    var name = ""
    var id = ""
    var friends : [Any]!
    let emailField: ErrorTextField = {
        let textField = ErrorTextField()
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.placeholder = "Email"
        textField.detail = "Error, incorrect email"
        textField.isClearIconButtonEnabled = true
        textField.placeholderActiveColor = Color.blue.base
        textField.dividerActiveColor = Color.blue.base
        return textField
    }()
    
    let passwordField: ErrorTextField = {
        let textField = ErrorTextField()
        textField.placeholder = "Password"
        textField.detail = "At least 8 characters"
        textField.clearButtonMode = .whileEditing
        textField.isVisibilityIconButtonEnabled = true
        textField.visibilityIconButton?.tintColor = (Color.blue.base).withAlphaComponent(textField.isSecureTextEntry ? 0.38 : 1.0)
        textField.placeholderActiveColor = Color.blue.base
        textField.dividerActiveColor = Color.blue.base
        return textField
    }()
    
    let login: RaisedButton = {
        let button = RaisedButton(title: "Login", titleColor: Color.blue.darken4)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        button.pulseColor = .gray
        button.pulseAnimation = .centerWithBacking
        button.depthPreset = .depth4
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(loginFunction), for: .touchUpInside)
        return button
    }()
    
    var loginButton : Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.toolbarController?.prepare()
        prepareNavigation()
        prepareTextFields()
        prepareButtons()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareTransition() {
        let tabs = AppTabBarController(viewControllers: [AppNavigationController(rootViewController: MessageViewController()),TrendingViewController(),ViewController(),AppNavigationController(rootViewController: SearchViewController()),AppNavigationController(rootViewController: AccountController())])

        UIApplication.shared.keyWindow?.rootViewController = tabs
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func configureFacebook() {
            Facebook.loginFacebook { (result) in
                self.prepareTransition()
        }
    }
    
    @objc func loginFunction() {
        RestAPI.rest.login(email: emailField.text!, password: passwordField.text!) { token in
            UserDefaults.standard.set(token, forKey: "token")
            self.prepareTransition()
        }
    }
}

extension LoginViewController {
    fileprivate func prepareNavigation() {
        navigationItem.title = "Login"
        navigationItem.titleLabel.textColor = Color.blue.base
    }
    
    fileprivate func prepareTextFields() {
        view.layout(emailField).top(50)
            .height(30)
            .width(250)
            .centerHorizontally()
        
        view.layout(passwordField).top(emailField.layoutMargins.top + 100)
            .height(30)
            .width(250)
            .centerHorizontally()
        
    }
    
    fileprivate func prepareButtons() {
        loginButton = RaisedButton(title: "Login with Facebook", titleColor: Color.white)
        loginButton.backgroundColor = Color.blue.darken4
        loginButton.depthPreset = .depth4
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        loginButton.addTarget(self, action: #selector(configureFacebook), for: .touchUpInside)
        loginButton.contentScaleFactor = UIScreen.main.scale


        view.layout(login).centerHorizontally()
            .centerVertically()
            .left(40)
            .right(40)
            .height(40)
        
        view.layout(loginButton).centerHorizontally()
            .left(40)
            .right(40)
            .height(40)
            .centerVertically(offset: 50)
    }
    
}
