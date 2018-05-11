//
//  APIClient.swift
//  FirebaseDemoMaster
//
//  Created by Sahil Lamba on 2/16/18.
//  Copyright © 2018 Vidya Ravikumar. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class APIClient {
    static func fetchPosts(withBlock: @escaping (Post) -> ()) {
        //TODO: Implement a method to fetch posts with Firebase!
        let ref = Database.database().reference()
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = Post(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
            withBlock(post)
        })
    }
    
    static func fetchUser(id: String, withBlock: @escaping (Users) -> ()) {
        //TODO: Implement a method to fetch posts with Firebase!
        let ref = Database.database().reference()
        ref.child("Users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = Users(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
            withBlock(user)
            
        })
    }
    static func createNewPost(postsRef: DatabaseReference,key: String, title: String, postText: String, poster: String,
                              imageUrl: String, posterId: String, num: Int, timePicked: String) {
//        let postsRef = Database.database().reference().child("Posts")
        print("I WSA CALLED")
        let newPost = ["title" : title, "text": postText, "poster": poster, "imageUrl": imageUrl, "posterId": posterId, "num": num, "timePicked": timePicked] as [String : Any]
//        let key = postsRef.childByAutoId().key
        let childUpdates = ["/\(key)/": newPost]
        postsRef.updateChildValues(childUpdates)
    }
    
    static func createNewUser(id: String, name: String, username: String) {
        let usersRef = Database.database().reference().child("Users")
        let newUser = ["name": name, "username": username]
        let childUpdates = ["/\(id)/": newUser]
        usersRef.updateChildValues(childUpdates)
    }
}



