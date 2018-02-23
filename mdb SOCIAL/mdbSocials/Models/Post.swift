//
//  Post.swift
//  FirebaseDemoMaster
//
//  Created by Vidya Ravikumar on 9/22/17.
//  Copyright © 2017 Vidya Ravikumar. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class Post {
    var eventTitle: String?
    var eventDescribed: String?
    var imageUrl: String?
    var dateSelected: String?
    var posterId: String?
    var poster: String?
    var id: String?
    var image: UIImage?
    var num: Int?
    
    // local variable
    var interestedUsers: [String] = []
    
    init(id: String, postDict: [String:Any]?) {
        self.id = id
        if postDict != nil {
            if let eventTitle = postDict!["title"] as? String {
                self.eventTitle = eventTitle
            }
            if let eventDescribed = postDict!["eventDescribed"] as? String {
                self.eventDescribed = eventDescribed
            }
            if let imageUrl = postDict!["imageUrl"] as? String {
                self.imageUrl = imageUrl
            }
            if let dateSelected = postDict!["dateSelected"] as? String {
                self.dateSelected = dateSelected
            }
            if let posterId = postDict!["posterId"] as? String {
                self.posterId = posterId
            }
            if let poster = postDict!["poster"] as? String {
                self.poster = poster
            }
            if let text = postDict!["text"] as? String {
                self.eventDescribed = text
            }
            if let num = postDict!["num"] as? Int {
                self.num = num
            }
            if let time = postDict!["timePicked"] as? String {
                self.dateSelected = time
        }
            
        }
    }
    
    init() {
        
    }
    
    func addInterestedUser(uid: String, withBlock: ()-> ()) {
        //update local array
        interestedUsers.append(uid)
        
        // update database
        let ref = Database.database().reference().child("Posts")
        let childUpdates = ["\(self.id!)/num": num!+1]
        ref.updateChildValues(childUpdates)
        withBlock()
        
    }
    
//    func rmInterestedUser(id: String) {
//        //remove local array
//        interestedUsers.append(id)
//        
//        // update database
//        var ref = Database.database().reference().child("Posts")
//        let childUpdates = ["/\(self.id)/num": num!-1]
//        ref.updateChildValues(childUpdates)
//    }
    
    
//    init() {
//        self.text = "This is a god dream"
//        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
//        self.id = "1"
//        self.poster = "Kanye West"
//    }
    
}

