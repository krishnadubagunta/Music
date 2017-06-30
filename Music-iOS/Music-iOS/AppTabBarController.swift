//
//  AppTabBarController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/21/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import UIKit
import Material

class AppTabBarController: PageTabBarController {
    
    var buttons = [Button]()
    
    open override func prepare() {
        super.prepare()
        
        delegate = self

        prepareTabbar()
        
        Motion.delay(0) { [weak self] in
            self?.selectedIndex = 1
        }
    }
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
}


extension AppTabBarController {
    
fileprivate func prepareTabbar() {
    pageTabBar.backgroundColor = Color.white
    pageTabBar.dividerColor = nil
    pageTabBar.lineAlignment = .bottom
    pageTabBar.lineColor = Color.blue.base
    pageTabBar.interimSpacePreset = .interimSpace9
}
    
}

extension AppTabBarController: PageTabBarControllerDelegate {
    func pageTabBarController(pageTabBarController: PageTabBarController, didTransitionTo viewController: UIViewController) {
        //print("pageTabBarController", pageTabBarController, "didTransitionTo viewController:", viewController)
    }
    
}
