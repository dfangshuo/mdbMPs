//
//  StatsViewController.swift
//  Match the Members!
//
//  Created by Fang on 2/7/18.
//  Copyright © 2018 fang. All rights reserved.
//

import QuartzCore
import UIKit

class StatsViewController: UIViewController {
    
    var pictures: [UIImage] = []
    var corrects: [String] = []
    var answers: [String] = []
    var streak: Int?
    
    var longestStreak: UILabel!
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    
    var choice1: UILabel!
    var choice2: UILabel!
    var choice3: UILabel!
    
    var correct1: UILabel!
    var correct2: UILabel!
    var correct3: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // streak
        longestStreak = UILabel(frame: CGRect(x: view.frame.width/2-62, y:50, width: view.frame.width-40, height: 50))
        longestStreak.textColor = UIColor.gray
        longestStreak.text = "Longest Streak: \(streak!)"
        self.view.addSubview(longestStreak)
        
        // images
        imageView1 = UIImageView(frame: CGRect(x: 40, y: 105, width: 120, height: 120))
        imageView1.layer.cornerRadius = 10
        imageView1.clipsToBounds = true
        imageView1.image = pictures[0]
        view.addSubview(imageView1)
        
        imageView2 = UIImageView(frame: CGRect(x: 40, y: 235, width: 120, height: 120))
        imageView2.layer.cornerRadius = 10
        imageView2.clipsToBounds = true
        imageView2.image = pictures[1]
        view.addSubview(imageView2)
        
        imageView3 = UIImageView(frame: CGRect(x: 40, y: 365, width: 120, height: 120))
        imageView3.layer.cornerRadius = 10
        imageView3.clipsToBounds = true
        imageView3.image = pictures[2]
        view.addSubview(imageView3)
        
        // labels
        correct1 = UILabel(frame: CGRect(x: view.frame.width/2-27, y:110, width: view.frame.width-40, height: 50))
        correct1.textColor = UIColor.gray
        correct1.text = "\(corrects[0])"
        choice1 = UILabel(frame: CGRect(x: view.frame.width/2-27, y:150, width: view.frame.width-40, height: 50))
        choice1.textColor = UIColor.gray
        choice1.text = "Your Answer: \(answers[0])"
        self.view.addSubview(correct1)
        self.view.addSubview(choice1)
        
        correct2 = UILabel(frame: CGRect(x: view.frame.width/2-27, y:240, width: view.frame.width-40, height: 50))
        correct2.textColor = UIColor.gray
        correct2.text = "\(corrects[1])"
        choice2 = UILabel(frame: CGRect(x: view.frame.width/2-27, y:280, width: view.frame.width-40, height: 50))
        choice2.textColor = UIColor.gray
        choice2.text = "Your Answer: \(answers[1])"
        self.view.addSubview(correct2)
        self.view.addSubview(choice2)
        
        correct3 = UILabel(frame: CGRect(x: view.frame.width/2-27, y:370, width: view.frame.width-40, height: 50))
        correct3.textColor = UIColor.gray
        correct3.text = "\(corrects[2])"
        choice3 = UILabel(frame: CGRect(x: view.frame.width/2-27, y:410, width: view.frame.width-40, height: 50))
        choice3.textColor = UIColor.gray
        choice3.text = "Your Answer: \(answers[2])"
        self.view.addSubview(correct3)
        self.view.addSubview(choice3)
        
        /***********************************************************************************************************/
        /********************************************* NAVIGATION BARS *********************************************/
        /***********************************************************************************************************/
        
        let staticBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 15))
        staticBar.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        self.view.addSubview(staticBar)
        
        // NavBar
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 693, width: view.frame.size.width, height:44))
        navigationBar.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Match the Members!"
        
        let stats = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(toBack))
        navigationItem.leftBarButtonItem = stats
        
        navigationBar.items = [navigationItem]
        
        self.view.addSubview(navigationBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toBack (_ sender: Any) {
        self.performSegue(withIdentifier: "backToMain", sender: sender)
        
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
