//
//  User.swift
//  FirebaseDemoMaster
//
//  Created by Vidya Ravikumar on 9/22/17.
//  Copyright © 2017 Vidya Ravikumar. All rights reserved.
//

import Foundation
import UIKit

class Users {
    var name: String?
    var email: String?
    var id: String?
    
    init(id: String, userDict: [String:Any]?) {
        self.id = id
        if userDict != nil {
            if let name = userDict!["name"] as? String {
                self.name = name
            }
            if let email = userDict!["email"] as? String {
                self.email = email
            }
            
        }
    }
    
    init() {
        
    }
    
    static func getCurrentUser(withId: String, block: @escaping (Users) -> ()) {
        APIClient.fetchUser(id: withId, withBlock: {(users) in
            block(users)
        })
    }
    
    
}

