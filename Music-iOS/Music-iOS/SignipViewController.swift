//
//  SignipViewController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/23/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material
import Photos

class SignipViewController: UIViewController, UIImagePickerControllerDelegate {

    var fnameField : ErrorTextField!
    var lnameField : ErrorTextField!
    var passwordField : ErrorTextField!
    var emailField : ErrorTextField!
    var profilePicture : Button!
    var picker : UIPickerView!
    var dataForPicker = ["Male","Female","Other"]
    var pickedValueFromPicker : String!
    var top = 0 as CGFloat
    var signup : Button!
    var profileImage : UIImage!
    
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
    
    @objc func uploadPhoto() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        alert.addAction(UIAlertAction.init(title: "Take Photo", style: .default, handler: { (action) in
            
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                imagePicker.modalPresentationStyle = .fullScreen
                self.present(imagePicker, animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "Choose Photo", style: .default, handler: { (action) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        if let image = info["UIImagePickerControllerEditedImage"] as? UIImage {
            self.dismiss(animated: true) {
                self.profilePicture.setImage(image, for: .normal)
            }
        }
        
        if var image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.dismiss(animated: true, completion: {
                image = (image.resize(toWidth: 150)?.resize(toHeight: 150))!
                self.profileImage = image
                self.profilePicture.setImage(image, for: .normal)
                self.profilePicture.imageView?.contentMode = .scaleAspectFill
                
            })
        }
        
    }
    
    func validateEmail(email : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    @objc func signUpHandler() {
        
        if (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! || (fnameField.text?.isEmpty)! || (lnameField.text?.isEmpty)! {
            let alert = UIAlertController.init(title: "All fields are required", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if !(validateEmail(email: emailField.text!)) {
            let alert = UIAlertController.init(title: "Email Invalid", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        else{

            let alertConfirm = UIAlertController.init(title: "Confirm Password", message: nil, preferredStyle: .alert)
            alertConfirm.addTextField(configurationHandler: { (textField) in
                textField.autocapitalizationType = .none
                textField.keyboardType = .default
                textField.isSecureTextEntry = true
            })
            alertConfirm.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
                if alertConfirm.textFields?[0].text == self.passwordField.text {
                        self.confirmSignup()
                        alertConfirm.dismiss(animated: true, completion: nil)
                }
                else{
                    alertConfirm.textFields?[0].text = ""
                }
            }))
            alertConfirm.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertConfirm, animated: true, completion: nil)
            
        }
        
    }
    
    func confirmSignup() {
        let imageData : Data?
        var profileString = ""
        if self.profilePicture.image(for: .normal) != #imageLiteral(resourceName: "camera") {
         imageData = UIImageJPEGRepresentation(self.profilePicture.image(for: .normal)!, 0)
         profileString = (imageData?.base64EncodedString())!
        }
        print(profileString)
        RestAPI.rest.signUp(firstName: fnameField.text!, lastName: lnameField.text!, email: emailField.text!, Password: passwordField.text!, Profile: profileString, gender: dataForPicker[picker.selectedRow(inComponent: 0)], completion: {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        })
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
        emailField.autocapitalizationType = .none
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
            .centerVertically(offset: -130)
        
        view.layout(lnameField)
            .width(200)
            .height(30)
            .centerVertically(offset: -80)
            .centerHorizontally()
        
        view.layout(emailField)
            .width(200)
            .height(30)
            .centerHorizontally()
            .centerVertically(offset: -30)
        
        view.layout(passwordField)
            .width(200)
            .height(30)
            .centerHorizontally()
            .centerVertically(offset: 20)
        
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
        signup.pulseAnimation = .centerWithBacking
        signup.addTarget(self, action: #selector(signUpHandler), for: .touchUpInside)
        view.layout(signup)
            .centerHorizontally()
            .centerVertically(offset: 180)
            .height(40)
            .width(200)
        
        profilePicture = RaisedButton(frame: CGRect(origin: CGPoint.zero, size: CGSize.init(width: 100, height: 100)))
        profilePicture.layer.cornerRadius = 50
        profilePicture.borderColor = Color.blue.base
        profilePicture.borderWidth = 1.0
        profilePicture.pulseAnimation = .centerWithBacking
        profilePicture.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        profilePicture.clipsToBounds = true
        profilePicture.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
        view.layout(profilePicture).centerHorizontally()
            .centerVertically(offset: -190)
            .width(100)
            .height(100)
        
    }
    
    fileprivate func prepareView() {
        prepareNavigation()
        prepareFields()
        prepareButton()
    }
    
}
