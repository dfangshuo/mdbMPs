//
//  SignupViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    // navigation
    var cancel: UIButton!

    
    // UI Elements
    var imageView: UIImageView!
    var uLabel: UILabel!
    var pLabel: UILabel!
    var nLabel: UILabel!
    var iLabel: UILabel!
    
    // textFields
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var repeatTextField: UITextField!
    var nameTextField: UITextField!
    var unameTextField: UITextField!

    //buttons
    var signupButton: UIButton!

    // saved parameters
    var userDict = [String: Any]();
//    var nameEntered: String!
//    var usernameEntered: String!
    
    // user model
    var madeUser = Users();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLayout() {
        
        nLabel = UILabel(frame: CGRect(x: 16, y: 180, width: UIScreen.main.bounds.width - 20, height: 40))
        nLabel.text = "Full Name"
        nLabel.textColor = UIColor.lightGray
        nLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        nLabel.font = nLabel.font.withSize(19)
        view.addSubview(nLabel)

        nameTextField = UITextField(frame: CGRect(x: 10, y: 221, width: UIScreen.main.bounds.width - 20, height: 40))
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.layer.cornerRadius = 10
        nameTextField.placeholder = "  Full Name"
        nameTextField.layer.borderColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9).cgColor
        nameTextField.layer.borderWidth = 1.3
        nameTextField.textColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        self.view.addSubview(nameTextField)
        
        uLabel = UILabel(frame: CGRect(x: 16, y: 266, width: UIScreen.main.bounds.width - 20, height: 40))
        uLabel.text = "Email"
        uLabel.textColor = UIColor.lightGray
        uLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        uLabel.font = uLabel.font.withSize(19)
        view.addSubview(uLabel)
        
        emailTextField = UITextField(frame: CGRect(x: 10, y: 305, width: UIScreen.main.bounds.width - 20, height: 40))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.placeholder = "  Enter email"
        //        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9).cgColor
        emailTextField.layer.borderWidth = 1.3
        //        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        self.view.addSubview(emailTextField)
        
        iLabel = UILabel(frame: CGRect(x: 16, y: 348, width: UIScreen.main.bounds.width - 20, height: 40))
        iLabel.text = "Username"
        iLabel.textColor = UIColor.lightGray
        iLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        iLabel.font = iLabel.font.withSize(19)
        view.addSubview(iLabel)
        
        unameTextField = UITextField(frame: CGRect(x: 10, y: 385, width: UIScreen.main.bounds.width - 20, height: 40))
        unameTextField.adjustsFontSizeToFitWidth = true
        unameTextField.layer.cornerRadius = 10
        unameTextField.placeholder = "  Enter Username"
        //        emailTextField.layoutIfNeeded()
        unameTextField.layer.borderColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9).cgColor
        unameTextField.layer.borderWidth = 1.3
        //        emailTextField.layer.masksToBounds = true
        unameTextField.textColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        self.view.addSubview(unameTextField)
        
        pLabel = UILabel(frame: CGRect(x: 16, y: 430, width: UIScreen.main.bounds.width - 20, height: 40))
        pLabel.text = "Password"
        pLabel.textColor = UIColor.lightGray
        pLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        pLabel.font = pLabel.font.withSize(18)
        view.addSubview(pLabel)
        
        passwordTextField = UITextField(frame: CGRect(x: 10, y: 465, width: UIScreen.main.bounds.width - 20, height: 40))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.placeholder = "  Password"
        passwordTextField.layer.borderColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9).cgColor
        passwordTextField.layer.borderWidth = 1.3
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
        
        repeatTextField = UITextField(frame: CGRect(x: 10, y: 513, width: UIScreen.main.bounds.width - 20, height: 40))
        repeatTextField.adjustsFontSizeToFitWidth = true
        repeatTextField.layer.cornerRadius = 10
        repeatTextField.placeholder = "  Confirm Password"
        repeatTextField.layer.borderColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9).cgColor
        repeatTextField.layer.borderWidth = 1.3
        repeatTextField.layer.masksToBounds = true
        repeatTextField.textColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        repeatTextField.isSecureTextEntry = true
        self.view.addSubview(repeatTextField)
        
        signupButton = UIButton(frame: CGRect(x: 10, y: 0.8 * UIScreen.main.bounds.height+15, width: UIScreen.main.bounds.width - 20, height: 45))
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.layer.cornerRadius = 10
        signupButton.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        self.view.addSubview(signupButton)
        
        cancel = UIButton(frame:CGRect(x: (view.frame.width - 125)/2, y: 675, width: 125, height: 30))
        cancel.setTitleColor(UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9), for: .normal)
        cancel.setTitle("back", for: .normal)
        cancel.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        view.addSubview(cancel)
    }
    
    @objc func signUpPressed() {
        //TODO: Implement this method with Firebase!
        
        if nameTextField.text! == "" {
            throwError(info: "Please key in your name")
        } else if emailTextField.text! == "" {
            throwError(info: "Please enter your email")
        } else if unameTextField.text! == "" {
            throwError(info: "Please key in a username")
        } else if passwordTextField.text! == "" {
            throwError(info: "Please key in a password")
        } else if repeatTextField.text! == "" {
            throwError(info: "Please confirm your password")
        } else if (passwordTextField.text! != repeatTextField.text!) {
            throwError(info: "Passwords don't match!")
        } else {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
//            nameEntered = nameTextField.text!
//            usernameEntered = unameTextField.text!
            
            userDict["name"] = nameTextField.text!
            userDict["username"] = unameTextField.text!
            
                UserAuthHelper.createUser(userModel: madeUser, email: email, password: password, dictOfInfo: userDict, withBlock1: { self.performSegue(withIdentifier: "signUpToFeed", sender: self)}, withBlock2: {self.throwError(info: "Please make sure you entered a valid email and your password is longer than 6 characters")})
        }
    }
    
    func throwError(info: String) {
        let alert = UIAlertController(title: "\(info)", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "signUpToFeed" {
            let VC = segue.destination as! FeedViewController
            VC.currUser = madeUser
        }
    }
    
    @objc func toLogin() {
        self.dismiss(animated: true, completion: {})
    }
 

}
