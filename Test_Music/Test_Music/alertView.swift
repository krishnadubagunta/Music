//
//  alertView.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/9/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material

class alertView: View {

    let textF = TextField()
    
    override func draw(_ rect: CGRect) {
        textF.placeholder = "Playlist Name"
        textF.clearButtonMode = .whileEditing
        textF.isClearIconButtonEnabled = true
        layout(textF).center()
    }

}
