//
//  FeedViewController.swift
//  mdbSocials
//
//  Created by Fang on 2/20/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
    
    var tableView: UITableView!
    var indexSelected: Int!
    
    var postDir: [Post] = []
    
//    var retrievedImage: UIImage!
    
    // user model
    var currUser = Users()
    let AuthUser = Auth.auth().currentUser

    
    override func viewWillAppear(_ animated: Bool) {
        
        APIClient.fetchPosts(withBlock: {(posts) in
            self.postDir.insert(posts, at: 0)
            
            //            self.postDir.append(contentsOf: postDir)
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        APIClient.fetchUser(id: (AuthUser?.uid)!, withBlock: {(x) in
            self.currUser = x
        })
        
        makeNavBar()
        makeTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeNavBar() {
        // NavBar
        let filler = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 25))
        filler.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        view.addSubview(filler)
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 15, width: view.frame.width, height: 30))
        navigationBar.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "MDB Socials"
        
        
        let logout = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(logOut))
        let newPost = UIBarButtonItem(title: "New Event", style: .plain, target: self, action: #selector(toNewPost))

        navigationItem.leftBarButtonItem = logout
        navigationItem.rightBarButtonItem = newPost
        
        navigationBar.items = [navigationItem]
        
//        let logout = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(logOut))
//        self.navigationItem.setLeftBarButton(logout, animated: true)
        
//        newPost = UIBarButtonItem(title: "New Event", style: .plain, target: self, action: #selector(toNewPost))
//        self.navigationItem.setRightBarButton(newPost, animated: true)
        
        self.view.addSubview(navigationBar)

    }
    
    @objc func logOut() {
        UserAuthHelper.logOut(withBlock: {self.performSegue(withIdentifier: "logOut", sender: self)})
    }
    
    @objc func toNewPost() {
        self.performSegue(withIdentifier: "newPost", sender: self)
    }
    
    func makeTable() {
        tableView = UITableView(frame: CGRect(x: 0, y:135, width: view.frame.width, height: view.frame.height-135),
                                style: UITableViewStyle.plain)
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "posts")
        tableView.backgroundColor = UIColor.white
        tableView.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        if segue.identifier == "newPost" {
            let VC = segue.destination as! NewSocialViewController
            VC.postingUser = currUser
        }
        
        else if segue.identifier == "moreDetails" {
            let VC = segue.destination as! DetailViewController
            VC.info = postDir[indexSelected]
//            VC.imageAtCell = retrievedImage
            VC.postObjs = postDir
            
            VC.indice = indexSelected
        }
        
    }
 

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    // specifying number of sections in the TV
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 8
        return postDir.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "posts", for: indexPath)
            as! FeedTableViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
//        cell.img.image = nil
//        retrievedImage = nil
        ImageHelper.downloadPic(imageName:postDir[indexPath.row].id! ,withBlock: { img in
//            self.retrievedImage = img
            cell.img.image = img
//            cell.img.image = self.retrievedImage

        })
//        let storageRef = Storage.storage().reference()
////            storage.reference(withPath: "images")
//
//        let imageRef = storageRef.child("images/\(postDir[indexPath.row].id!)")
//
//        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if let error = error {
//
//            } else {
//                let toDisplay = UIImage(data: data!)
//                print(toDisplay)
//                cell.img.image = toDisplay
//            }
//        }
        
        
//        cell.img.image = postDir[indexPath.row]
//        print(postDir[indexPath.row].eventTitle)
        cell.name.text = postDir[indexPath.row].eventTitle
        cell.num.text = "\(String(describing: postDir[indexPath.row].num!)) person(s) is/are interested!"
        cell.poster.text = postDir[indexPath.row].poster

//        var img: UIImageView!
//        var button: UIButton!
//        var name: UILabel!
//        var num: UILabel!
        
//        let image = filteredPokemonInfo[indexPath.row].getImageFromURL()
//        cell.pokeImageView.image = image
//        cell.name.text = numPosts[indexPath.row].name
//        cell.num.text = "Call me: \(String(filteredPokemonInfo[indexPath.row].number))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        print(indexSelected)
        
        self.performSegue(withIdentifier: "moreDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

