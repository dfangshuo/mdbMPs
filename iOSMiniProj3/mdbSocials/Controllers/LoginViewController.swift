//
//  LoginViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // UI Elements
    var imageView: UIImageView!
    var noAcc: UILabel!
    var uLabel: UILabel!
    var pLabel: UILabel!
    
    // Email & Password
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    // Login and Signup Buttons
    var login: UIButton!
    var signup: UIButton!
    
    // user model
    var loginUser = Users();

//     checks if the user is logged in or not
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if Auth.auth().currentUser != nil {
//            self.performSegue(withIdentifier: "toFeed", sender: self)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(frame: CGRect(x: (view.frame.width-260)/2, y: 67, width: 277, height: 277))
        imageView.image = #imageLiteral(resourceName: "MDB Cover")
        view.addSubview(imageView)
        
        setupTextFields()
        setupButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set Up Text Fields
    func setupTextFields() {
        
        uLabel = UILabel(frame: CGRect(x: 16, y: 348, width: UIScreen.main.bounds.width - 20, height: 40))
        uLabel.text = "Email"
        uLabel.textColor = UIColor.lightGray
        uLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        uLabel.font = uLabel.font.withSize(19)
        view.addSubview(uLabel)
        
        emailTextField = UITextField(frame: CGRect(x: 10, y: 385, width: UIScreen.main.bounds.width - 20, height: 40))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.placeholder = "  Enter email"
//        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9).cgColor
        emailTextField.layer.borderWidth = 1.3
//        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        self.view.addSubview(emailTextField)
        
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
    }
    
    // Set Up Buttons
    func setupButtons() {
        login = UIButton(frame: CGRect(x: 10, y: 535, width: UIScreen.main.bounds.width - 20, height: 50))
        login.layer.cornerRadius = 10
        login.setTitle("Login", for: .normal)
        login.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        login.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        
        
        noAcc = UILabel(frame: CGRect(x: 13, y: 591, width: UIScreen.main.bounds.width - 20, height: 40))
        noAcc.text = "Don't have an account?"
        noAcc.textColor = UIColor.lightGray
        noAcc.font = noAcc.font.withSize(18)
        view.addSubview(noAcc)
        
        signup = UIButton(frame:CGRect(x: (view.frame.width - 250)/2 + 122, y: 597, width: 125, height: 30))
        signup.setTitleColor(UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9), for: .normal)
        signup.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        signup.setTitle("Sign up here", for: .normal)
        signup.addTarget(self, action: #selector(toSignUp), for: .touchUpInside)
        
        view.addSubview(login)
        view.addSubview(signup)
    }
    
    //Button Functions
    @objc func loginPressed() {
        if emailTextField.text! == "" {
            throwError(info: "email not found!")
        } else if passwordTextField.text! == "" {
            throwError(info: "please enter a password!")
        } else {
            UserAuthHelper.logIn(email: emailTextField.text!, password:passwordTextField.text!, withBlock1: {self.performSegue(withIdentifier: "toFeed", sender: self)}, withBlock2: {self.throwError(info: "Invalid Username/Password")})
            
            emailTextField.text = ""
            passwordTextField.text = ""
            
            
        }
    }
    
    @objc func toSignUp() {
        self.performSegue(withIdentifier: "toSignUp", sender: self)
    }
    
    func throwError(info: String) {
        let alert = UIAlertController(title: "\(info)", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "toFeed" {
//            let VC = segue.destination as! FeedViewController
//            VC.currUser = loginUser
//        }
//    }
// 

}




