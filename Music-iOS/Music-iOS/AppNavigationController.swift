//
//  AppNavigationController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/17/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import Material

class AppNavigationController: NavigationController {
    
    open override func prepare() {
        super.prepare()
        guard let v = navigationBar as? NavigationBar else {
            return
        }
        v.dividerColor = Color.clear
        v.depthPreset = .none
        v.backgroundColor = Color.white
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        switch rootViewController {
        case is MessageViewController:
            pageTabBarItem.image = #imageLiteral(resourceName: "mess")
            break
        case is SearchViewController :
            pageTabBarItem.image = #imageLiteral(resourceName: "search")
            break
        case is AccountController:
            pageTabBarItem.image = #imageLiteral(resourceName: "male")
            break;
        default:
            break
        }
        pageTabBarItem.depthPreset = .depth4
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Preferred status bar style lightContent to use on dark background.
    // Swift 3
    override var preferredStatusBarStyle: UIStatusBarStyle {
        //LightContent
        return UIStatusBarStyle.default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}


