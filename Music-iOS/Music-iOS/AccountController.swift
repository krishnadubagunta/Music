//
//  AccountController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/21/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material

class AccountController: UIViewController {

    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    var fbLogoutButton : Button!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareMenuButton()
        prepareStarButton()
        prepareNavigation()
        preparePageTabBarItem()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        prepareMenuButton()
        prepareStarButton()
        prepareNavigation()
        preparePageTabBarItem()
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
        fbLogoutButton = Button(image: #imageLiteral(resourceName: "logoutFB"))
        view.layout(fbLogoutButton).centerHorizontally()
            .bottom(40)
            .left(40)
            .right(40)
        .height(50)
        fbLogoutButton.imageView?.contentMode = .scaleAspectFill
        fbLogoutButton.pulseAnimation = .centerWithBacking
    }
    
    fileprivate func preparePageTabBarItem() {
        pageTabBarItem.image = #imageLiteral(resourceName: "female")
        pageTabBarItem.depthPreset = .depth4
    }
    
    fileprivate func prepareNavigation() {
        navigationItem.title = "Account"
        navigationItem.titleLabel.textColor = Color.blue.base
        navigationItem.leftViews = [menuButton]
        navigationItem.rightViews = [starButton]
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.add)
        starButton.tintColor = Color.blue.base
    }
    
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        //        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }

}


