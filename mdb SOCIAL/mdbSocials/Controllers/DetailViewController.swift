//
//  DetailViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {

    // layout
    var eventName: UILabel!
    var posterName: UILabel!
    var details: UILabel!
    var interestButton: UIButton!
    var eventImage: UIImageView!
    var dateTime: UILabel!
    var interestLvl: UILabel!
    
    // model
    var info = Post();
//    var imageAtCell: UIImage!
    var postObjs: [Post] = []
    var indice: Int!

    
    // navigation
    var cancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
//        imageAtCell = #imageLiteral(resourceName: "MDB Cover")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        
        eventName = UILabel(frame: CGRect(x: 13, y: 60, width: view.frame.width - 20, height: 40))
        eventName.text = info.eventTitle!
        eventName.clipsToBounds = true
        eventName.adjustsFontSizeToFitWidth = true
        eventName.font = eventName.font!.withSize(38)
        view.addSubview(eventName)
        
        posterName = UILabel(frame: CGRect(x: 13, y: 100, width: view.frame.width - 20, height: 40))
        posterName.text = "by \(info.poster!)"
        posterName.clipsToBounds = true
        posterName.adjustsFontSizeToFitWidth = true
        posterName.font = posterName.font!.withSize(25)
        posterName.textColor = UIColor.darkGray
        view.addSubview(posterName)
        
        eventImage = UIImageView(frame: CGRect(x: 13, y: 140, width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.width - 125  ))
//        if imageAtCell != nil {
//            eventImage.image = imageAtCell
//        }
        self.eventImage.image = #imageLiteral(resourceName: "MDB Cover")
        ImageHelper.downloadPic(imageName:postObjs[indice].id!, withBlock: { img in
            self.eventImage.image = img
        })
        
        
        view.addSubview(eventImage)
        
        dateTime = UILabel(frame: CGRect(x: 101, y: 440, width: self.view.frame.width-16, height: 20))
        dateTime.text = info.dateSelected!
        dateTime.clipsToBounds = true
        dateTime.textColor = UIColor.black
        dateTime.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(dateTime)
        
        interestLvl = UILabel(frame: CGRect(x: 125, y: 430, width: self.view.frame.width-16, height: 100))
        interestLvl.text = "People Interested: \(String(info.num!))"
        interestLvl.clipsToBounds = true
        interestLvl.textColor = UIColor.black
        interestLvl.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(interestLvl)
        
        details = UILabel(frame: CGRect(x: 8, y: 500, width: self.view.frame.width-16, height: 100))
        details.layoutIfNeeded()
        details.text = info.eventDescribed!
        details.layer.borderColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9).cgColor
        details.layer.borderWidth = 1.5
        details.layer.cornerRadius = 10
        details.layer.masksToBounds = true
        details.clipsToBounds = true
        details.textColor = UIColor.darkGray
        view.addSubview(details)
        
        interestButton = UIButton(frame: CGRect(x: 10, y: 0.8 * UIScreen.main.bounds.height+25, width: UIScreen.main.bounds.width - 20, height: 45))
        interestButton.layoutIfNeeded()
        
        if postObjs[indice].interestedUsers.contains(Auth.auth().currentUser!.uid) {
            interestButton.backgroundColor = UIColor(red: 0.7294, green: 0.898, blue: 0.5725, alpha: 1.0)
            interestButton.setTitle("i'm going ", for: .normal)
        } else {
            interestButton.setTitle("I'M INTERESTED", for: .normal)
            interestButton.backgroundColor = UIColor(red: 255/255, green: 124/255, blue: 124/255, alpha: 1.0)
        }


        
        
        interestButton.addTarget(self, action: #selector(interestShown), for: .touchUpInside)
        interestButton.layer.cornerRadius = 10
        view.addSubview(interestButton)
        
        cancel = UIButton(frame:CGRect(x: (view.frame.width - 125)/2, y: 675, width: 125, height: 30))
        cancel.setTitleColor(UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9), for: .normal)
        cancel.setTitle("back", for: .normal)
        cancel.addTarget(self, action: #selector(backBack), for: .touchUpInside)
        view.addSubview(cancel)
    }
    
    @objc func backBack() {
        self.dismiss(animated: true, completion: {})
    }
    
    @objc func interestShown() {
//        let postsRef = Database.database().reference().child("Posts")
        
//        self.dismiss(animated: true, completion: {})
        
        if interestButton.backgroundColor == UIColor(red: 255/255, green: 124/255, blue: 124/255, alpha: 1.0) {
            noToYes()
            interestButton.backgroundColor = UIColor(red: 0.7294, green: 0.898, blue: 0.5725, alpha: 1.0)
            interestButton.setTitle("i'm going ", for: .normal)
        } else {
            yesToNo()
            interestButton.backgroundColor = UIColor(red: 255/255, green: 124/255, blue: 124/255, alpha: 1.0)
            interestButton.setTitle("I'M INTERESTED", for: .normal)
        }
    }
    
    func noToYes() {
        // add to interestedUsers
        postObjs[indice].addInterestedUser(uid: Auth.auth().currentUser!.uid, withBlock: {
            interestLvl.text = "People Interested: \(String(info.num! + 1))"
//            self.interestLvl.removeFromSuperview()
//            view.addSubview(self.interestLvl)
        })

    }
    
    func yesToNo() {
//        postObjs[indice].interestedUsers = postObjs[indice].interestedUsers.filter{$0 != "\(Auth.auth().currentUser!.uid)"}
//        let ref = Database.database().reference().child("Posts")
//        let childUpdates = ["\(Auth.auth().currentUser!.uid)/num":postObjs[indice].num!-1]
//        ref.updateChildValues(childUpdates)
//        interestLvl.text = "People Interested: \(String(info.num! - 1))"

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
