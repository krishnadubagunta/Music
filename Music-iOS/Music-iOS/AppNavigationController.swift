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
    
    var buttons = [Button]()
    var tabBar : TabBar!
    
    open override func prepare() {
        super.prepare()
        guard let v = navigationBar as? NavigationBar else {
            return
        }
        v.dividerColor = Color.clear
        v.depthPreset = .none
        v.backgroundColor = Color.white
        prepareButtons()
        prepareTabbar()
        
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


extension AppNavigationController : TabBarDelegate {
    
    fileprivate func prepareTabbar() {
        tabBar = TabBar()
        tabBar.delegate = self
        tabBar.buttons = buttons
        tabBar.tintColor = Color.blue
        view.layout(tabBar).horizontally().bottom()
    }
    
    fileprivate func prepareButtons() {
        let btn1 = FlatButton(image: #imageLiteral(resourceName: "mess"), tintColor: Color.blue)
        btn1.pulseAnimation = .none
        buttons.append(btn1)
        
        let btn2 = FlatButton(image: #imageLiteral(resourceName: "follow"))
        btn2.pulseAnimation = .none
        buttons.append(btn2)
        
        let btn3 = FlatButton(image: #imageLiteral(resourceName: "audio_wave"), tintColor: Color.blue)
        btn3.pulseAnimation = .none
        buttons.append(btn3)
        
        let btn4 = FlatButton(image: #imageLiteral(resourceName: "search"), tintColor: Color.blue)
        btn4.pulseAnimation = .none
        buttons.append(btn4)
        
        let btn5 = FlatButton(image: #imageLiteral(resourceName: "male"), tintColor: Color.blue)
        btn5.pulseAnimation = .none
        buttons.append(btn5)
    }
    
    
    
    
}
