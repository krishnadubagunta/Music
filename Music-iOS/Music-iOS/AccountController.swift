//
//  AccountController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/21/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material
import FBSDKLoginKit

class AccountController: UIViewController {

    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    var fbLogoutButton : Button!
    var logoutButton : Button!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareMenuButton()
        prepareStarButton()
        prepareNavigation()

    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        prepareMenuButton()
        prepareStarButton()
        prepareNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareLogout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareTransition() {
        UIApplication.shared.keyWindow?.rootViewController = AppNavigationController(rootViewController: OnboardingViewController())
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func logoutFacebook() {
        let loginManager = FBSDKLoginManager.init()
        loginManager.logOut()
        self.prepareTransition()
    }
    
    @objc func logout() {
        UserDefaults.standard.removeObject(forKey: "token")
        self.prepareTransition()
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

extension AccountController {
    
    
    fileprivate func prepareLogout() {
        fbLogoutButton = RaisedButton(title: "Logout on Facebook", titleColor: Color.white)
        fbLogoutButton.backgroundColor = Color.blue.darken4
        fbLogoutButton.depthPreset = .depth4
        fbLogoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        fbLogoutButton.addTarget(self, action: #selector(logoutFacebook), for: .touchUpInside)
        view.layout(fbLogoutButton).centerHorizontally()
            .left(40)
            .right(40)
            .height(40)
            .bottom(100)
        
        logoutButton = RaisedButton(title: "Logout", titleColor: Color.blue.darken4)
        logoutButton.backgroundColor = Color.white
        logoutButton.depthPreset = .depth4
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        logoutButton.addTarget(self, action: #selector(logoutFacebook), for: .touchUpInside)
        view.layout(logoutButton).centerHorizontally()
            .left(40)
            .right(40)
            .height(40)
            .bottom(40)
        
        
    }
    
    
    fileprivate func prepareNavigation() {
        navigationItem.title = "Account"
        navigationItem.titleLabel.textColor = Color.blue.base
        navigationItem.leftViews = [menuButton]
        navigationItem.rightViews = [starButton]
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.add)
    }
    
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        //        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }

}


