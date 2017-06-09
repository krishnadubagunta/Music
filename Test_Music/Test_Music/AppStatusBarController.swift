//
//  AppStatusBarController.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/9/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import Foundation
import Material

class AppStatusBarController: StatusBarController {
    open override func prepare() {
        super.prepare()
        
        prepareStatusBar()
    }
}

extension AppStatusBarController {
    fileprivate func prepareStatusBar() {
        statusBarStyle = .lightContent
    }
}
