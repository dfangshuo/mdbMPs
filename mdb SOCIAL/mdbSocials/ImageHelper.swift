//
//  imageHelper.swift
//  mdbSocials
//
//  Created by Fang on 2/22/18.
//  Copyright © 2018 fang. All rights reserved.
//

import Foundation
import Firebase

class ImageHelper {
    
    static func downloadPic(imageName: String, withBlock: @escaping (UIImage) -> ()) {
    
    let storageRef = Storage.storage().reference()
    //            storage.reference(withPath: "images")
    
    print(imageName)
    let imageRef = storageRef.child("\(imageName)")
    print(imageRef)
    
    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
    imageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
    if let error = error {
        print("ERROR: \(error.localizedDescription)")
    } else {
        let toDisplay = UIImage(data: data!)
        withBlock(toDisplay!)
        }
    }
    }
    
}



