//
//  SignipViewController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/23/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material

class SignipViewController: UIViewController {

    var fnameField : ErrorTextField!
    var lnameField : ErrorTextField!
    var passwordField : ErrorTextField!
    var emailField : ErrorTextField!
    var picker : UIPickerView!
    var dataForPicker = ["Male","Female","Other"]
    var pickedValueFromPicker : String!
    var top = 0 as CGFloat
    var signup : Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        prepareView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension SignipViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    fileprivate func fieldGenerate() -> ErrorTextField {
        let field = ErrorTextField()
        field.isErrorRevealed = true
        field.dividerColor = Color.blue.base
        field.autocorrectionType = .no
        field.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
        return field
    }
    
    fileprivate func prepareNavigation() {
        navigationItem.title = "Signup"
        navigationItem.titleLabel.textColor = Color.blue.base
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    fileprivate func prepareFields(){
        fnameField = fieldGenerate()
        lnameField = fieldGenerate()
        passwordField = fieldGenerate()
        emailField = fieldGenerate()
        picker = UIPickerView(frame : CGRect(x: 0, y: 0, width: 10, height: 20))
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .white
//        picker.showsSelectionIndicator = true
        fnameField.keyboardType = .alphabet
        fnameField.placeholder = "First name"
        fnameField.autocapitalizationType = .words
        lnameField.placeholder = "Last name"
        lnameField.keyboardType = .alphabet
        lnameField.autocapitalizationType = .words
        emailField.keyboardType = .emailAddress
        emailField.placeholder = "Email"
        
        passwordField.isSecureTextEntry = true
        passwordField.isVisibilityIconButtonEnabled = true
        passwordField.placeholder = "Password"
        passwordField.visibilityIconButton?.tintColor = (Color.blue.base).withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 1.0)
        passwordField.keyboardType = .default
        
        view.layout(fnameField)
            .width(200)
            .height(30)
            .centerHorizontally()
            .centerVertically(offset: -180)
        
        view.layout(lnameField)
            .width(200)
            .height(30)
            .centerVertically(offset: -120)
            .centerHorizontally()
        
        view.layout(emailField)
            .width(200)
            .height(30)
            .centerHorizontally()
            .centerVertically(offset: -60)
        
        view.layout(passwordField)
            .width(200)
            .height(30)
            .centerHorizontally()
            .centerVertically(offset: 0)
        
        view.layout(picker)
            .width(200)
            .height(100)
            .centerHorizontally()
            .centerVertically(offset: 100)
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = dataForPicker[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium),NSForegroundColorAttributeName: Color.blue.base])
        return myTitle
    }
    
    fileprivate func prepareButton() {
        signup = RaisedButton(title: "Signup", titleColor: Color.blue.darken4)
        signup.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        signup.depthPreset = .depth4
        view.layout(signup)
            .centerHorizontally()
            .centerVertically(offset: 180)
            .height(40)
            .width(200)
    }
    
    fileprivate func prepareView() {
        prepareNavigation()
        prepareFields()
        prepareButton()
    }
    
}
