//
//  AppNavigationController.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/9/17.
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
        
        let vb = navigationItem
        vb.titleLabel.tintColor = Color.red
        v.barTintColor = Color.white
        v.depthPreset = .depth3
        v.dividerColor = Color.white
    }
    
    // Preferred status bar style lightContent to use on dark background.
    // Swift 3
    override var preferredStatusBarStyle: UIStatusBarStyle {
        //LightContent
        return UIStatusBarStyle.default
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
