//
//  UserAuthHelper.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserAuthHelper {
    
    // creates a user
    static func createUser(userModel: Users ,email: String, password: String, dictOfInfo: [String:Any], withBlock1: @escaping () -> (), withBlock2: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil && user != nil {
                print("User created!")
                let name = dictOfInfo["name"] as! String
                let username = dictOfInfo["username"] as!String
                APIClient.createNewUser(id: (user?.uid)!, name: name, username: username)
                userModel.name = name
                userModel.id = (user?.uid)!
                withBlock1()
            }
            else {
                print("Error Creating User: \(error.debugDescription)")
                withBlock2()
            }
        })
    }
    
    // log in
    static func logIn(email: String, password: String, withBlock1: @escaping ()->() , withBlock2: @escaping ()->()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                print("Log In Successful")
        
//                APIClient.fetchUser(id: (user?.uid)!, withBlock: { (snapshot) in
//                    let user = Users(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
//                    withBlock1(user)
//                })
//                loginUser.id = (user?.uid)!
                withBlock1()
            }
            else {
                withBlock2()
                print("Error Logging In: \(error.debugDescription)")
            }
        })
    }
    
    // log out
    static func logOut(withBlock: @escaping ()->()) {
        //TODO: Log out using Firebase!
        let firebaseAuth = Auth.auth()
        do {
            print("Log Out Successful")
            try firebaseAuth.signOut()
            withBlock()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

