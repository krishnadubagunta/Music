//
//  OnboardingView.swift
//  OnboardingSample
//
//  Created by Sai Krishna Dubagunta on 6/14/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material

class OnboardingView: View {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var imageView : UIImageView = UIImageView(frame: UIScreen.main.bounds)
    
    override func prepare() {
        self.layout(imageView).centerVertically()
            .centerHorizontally()
            .bottom(0)
            .right(0)
            .left(0)
            .top(0)
    }
    
    
    

}
