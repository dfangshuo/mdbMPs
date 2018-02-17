//
//  MainViewController.swift
//  Match the Members!
//
//  Created by Fang on 2/7/18.
//  Copyright © 2018 fang. All rights reserved.
//

import QuartzCore
import UIKit

class MainViewController: UIViewController {
    
    //Images
    var imageView: UIImageView!
    
    // Buttons
    var optionOne: UIButton!
    var optionTwo: UIButton!
    var optionThree: UIButton!
    var optionFour: UIButton!
    var startStop: UIButton!
    
    // stats trackers
    var streak = 0;
    var longestStreak = 0;
    var lastThreeNames = ["-","-","-"]
    var lastThreePictures = [#imageLiteral(resourceName: "white_obx"), #imageLiteral(resourceName: "white_obx"),#imageLiteral(resourceName: "white_obx")]
    var lastThreeChoices = ["-","-","-"]
    
    
    // score counters
    var correct: String?
    var scoreCount = 0;
    var score: UILabel!
    
    // timers
    var timer1 = Timer()
    var timer2 = Timer()
    

    //data
    let imageArray = [#imageLiteral(resourceName: "danielandrews"),#imageLiteral(resourceName: "nikhararora"),#imageLiteral(resourceName: "tigerchen"),#imageLiteral(resourceName: "xinyichen"),#imageLiteral(resourceName: "juliedeng"),#imageLiteral(resourceName: "radhikadhomse"),#imageLiteral(resourceName: "kadendippe"),#imageLiteral(resourceName: "angeladong"),#imageLiteral(resourceName: "zachgovani"),#imageLiteral(resourceName: "shubhamgupta"),#imageLiteral(resourceName: "suyashgupta"),#imageLiteral(resourceName: "joeyhejna"),#imageLiteral(resourceName: "codyhsieh"),#imageLiteral(resourceName: "stephenjayakar"),#imageLiteral(resourceName: "aneeshjindal"),#imageLiteral(resourceName: "mohitkatyal"),#imageLiteral(resourceName: "mudabbirkhan"),#imageLiteral(resourceName: "akkshaykhoslaa"),#imageLiteral(resourceName: "justinkim"),#imageLiteral(resourceName: "erickong"),#imageLiteral(resourceName: "abhinavkoppu"),#imageLiteral(resourceName: "srujaykorlakunta"),#imageLiteral(resourceName: "ayushkumar"),#imageLiteral(resourceName: "shivkushwah"),#imageLiteral(resourceName: "leonkwak"),#imageLiteral(resourceName: "sahillamba"),#imageLiteral(resourceName: "younglin"),
                      #imageLiteral(resourceName: "williamlu"),#imageLiteral(resourceName: "louiemcconnell"),#imageLiteral(resourceName: "maxmiranda"),#imageLiteral(resourceName: "willoakley"),#imageLiteral(resourceName: "noahpepper"),#imageLiteral(resourceName: "samanvirai"),#imageLiteral(resourceName: "krishnanrajiyah"),#imageLiteral(resourceName: "vidyaravikumar"),#imageLiteral(resourceName: "shreyareddy"),#imageLiteral(resourceName: "amyshen"),#imageLiteral(resourceName: "wilburshi"),#imageLiteral(resourceName: "sumukhshivakumar"),#imageLiteral(resourceName: "fangshuo"),#imageLiteral(resourceName: "japjotsingh"),#imageLiteral(resourceName: "victorsun"),#imageLiteral(resourceName: "sarahtang"),#imageLiteral(resourceName: "kanyesthaker"),#imageLiteral(resourceName: "aayushtyagi"),#imageLiteral(resourceName: "leviwalsh"),#imageLiteral(resourceName: "carolwang"),#imageLiteral(resourceName: "shariewang"),#imageLiteral(resourceName: "ethanwong"),#imageLiteral(resourceName: "natashawong"),#imageLiteral(resourceName: "adityayadav"),#imageLiteral(resourceName: "candiceye"),#imageLiteral(resourceName: "vineethyeevani"),#imageLiteral(resourceName: "jeffreyzhang")]
    let nameArray = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", "Srujay Korlakunta", "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", "Jeffrey Zhang"]
    let MEMBERS = 54;
    var orderedMembers = [-1,-1,-1,-1]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create image
        imageView = UIImageView(frame: CGRect(x: (view.frame.width-260)/2, y: 85, width: 260, height: 260))
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        // Create buttons
        optionOne = UIButton(frame: CGRect(x: 15, y: 365, width: view.frame.width / 2 - 20, height: 80))
        optionOne.layer.cornerRadius = 10
        optionOne.clipsToBounds = true
        optionTwo = UIButton(frame: CGRect(x: 10 + view.frame.width / 2, y: 365, width: view.frame.width / 2 - 20, height: 80))
        optionTwo.layer.cornerRadius = 10
        optionTwo.clipsToBounds = true
        optionThree = UIButton(frame: CGRect(x: 15, y: 455, width: view.frame.width / 2 - 20, height: 80))
        optionThree.layer.cornerRadius = 10
        optionThree.clipsToBounds = true
        optionFour = UIButton(frame: CGRect(x: 10 + view.frame.width / 2, y: 455, width: view.frame.width / 2 - 20, height: 80))
        optionFour.layer.cornerRadius = 10
        optionFour.clipsToBounds = true
        
        optionOne.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        view.addSubview(optionOne)
        optionOne.addTarget(self, action: #selector(onClickOne), for: .touchUpInside)
        
         //Option 2
        optionTwo.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        view.addSubview(optionTwo)
        optionTwo.addTarget(self, action: #selector(onClickTwo), for: .touchUpInside)
        
         //Option 3
        optionThree.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        view.addSubview(optionThree)
        optionThree.addTarget(self, action: #selector(onClickThree), for: .touchUpInside)
        
         //Option 4
        optionFour.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        view.addSubview(optionFour)
        optionFour.addTarget(self, action: #selector(onClickFour), for: .touchUpInside)
        
        

        correct = nameArray[setup()]

        // Button to Start/Stop
        startStop = UIButton(frame: CGRect(x: 20, y: 565, width: view.frame.width - 40, height: 50))
        startStop.layer.cornerRadius = 30
        startStop.clipsToBounds = true
        startStop.backgroundColor = UIColor(red: 1, green: 0.85, blue: 0.95, alpha: 0.8)
        startStop.setTitle("Stop", for: .normal)
        view.addSubview(startStop)
        startStop.addTarget(self, action: #selector(startOrStop), for: .touchUpInside)
        
        // Score
        score = UILabel(frame: CGRect(x: view.frame.width/2-27, y:620, width: view.frame.width-40, height: 50))
        scoreMaker(scoreCount)
                
        /***********************************************************************************************************/
        /********************************************* NAVIGATION BARS *********************************************/
        /***********************************************************************************************************/
 
        // Static Navigation Bar
        let staticBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 25))
        staticBar.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        self.view.addSubview(staticBar)
        
        // NavBar
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 693, width: view.frame.size.width, height:44))
        navigationBar.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Match the Members!"
        
        
        let stats = UIBarButtonItem(title: "stats", style: .plain, target: self, action: #selector(toStats))
        navigationItem.leftBarButtonItem = stats

        navigationBar.items = [navigationItem]
        
        self.view.addSubview(navigationBar)

    }

    /***********************************************************************************************************/
    /***************************** TIMER FUNCTIONS ************************************************************/
    /***********************************************************************************************************/
    
    @objc func refresh() {
        self.view.isUserInteractionEnabled = true
        optionOne.isEnabled = true
        optionTwo.isEnabled = true
        optionThree.isEnabled = true
        optionFour.isEnabled = true
        correct = nameArray[setup()]
    }
    
    @objc func noChoiceRefresh() {
        updateStats(correct!, "-", imageView.image!)
        correct = nameArray[setup()]
    }
    
    @IBAction func startOrStop(_ sender:Any) {
        if startStop.backgroundColor == UIColor(red: 1, green: 0.85, blue: 0.95, alpha: 0.8) {
            stop()
        }
        else {
            resume()
        }
    }
    
    func stop() {
        startStop.backgroundColor = UIColor.green
        startStop.setTitle("Resume", for: .normal)
        timer1.invalidate()
        optionOne.isEnabled = false
        optionTwo.isEnabled = false
        optionThree.isEnabled = false
        optionFour.isEnabled = false
    }
    
    func resume() {
        refresh()
        startStop.backgroundColor = UIColor(red: 1, green: 0.85, blue: 0.95, alpha: 0.8)
        startStop.setTitle("Stop", for: .normal)

    }
    
    @IBAction func toStats(_ sender:Any) {
        stop()
        self.performSegue(withIdentifier: "stats", sender: sender)
    }
    /***********************************************************************************************************/
    /***************************** BUTTON FUNCTIONS ************************************************************/
    /***********************************************************************************************************/
    @IBAction func onClickOne(_ sender: Any) {
        timer1.invalidate()
        self.view.isUserInteractionEnabled = false
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refresh), userInfo: nil, repeats: false)

        if optionOne.titleLabel!.text! == correct! {
            optionOne.backgroundColor = UIColor.green
            scoreCount += 1
            streak += 1
            if streak > longestStreak {
                longestStreak = streak
            }
            scoreMaker(scoreCount)
        }
        else {
            optionOne.backgroundColor = UIColor.red
            if streak > longestStreak {
                longestStreak = streak
            }
            streak = 0
        }
        updateStats(correct!, optionOne.titleLabel!.text!, imageView.image!)

    }
    
    @IBAction func onClickTwo(_ sender: Any) {
        timer1.invalidate()
        self.view.isUserInteractionEnabled = false
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refresh), userInfo: nil, repeats: false)

        if optionTwo.titleLabel!.text! == correct! {
            optionTwo.backgroundColor = UIColor.green
            scoreCount += 1
            streak += 1
            if streak > longestStreak {
                longestStreak = streak
            }
            scoreMaker(scoreCount)
        }
        else {
            optionTwo.backgroundColor = UIColor.red
            if streak > longestStreak {
                longestStreak = streak
            }
            streak = 0
        }
        updateStats(correct!, optionTwo.titleLabel!.text!, imageView.image!)
    }
    
    @IBAction func onClickThree(_ sender: Any) {
        timer1.invalidate()
        self.view.isUserInteractionEnabled = false
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refresh), userInfo: nil, repeats: false)
        if optionThree.titleLabel!.text! == correct! {
            optionThree.backgroundColor = UIColor.green
            scoreCount += 1
            streak += 1
            if streak > longestStreak {
                longestStreak = streak
            }
            scoreMaker(scoreCount)

        }
        else {
            optionThree.backgroundColor = UIColor.red
            if streak > longestStreak {
                longestStreak = streak
            }
            streak = 0
        }
        updateStats(correct!, optionThree.titleLabel!.text!, imageView.image!)
    }
    
    @IBAction func onClickFour(_ sender: Any) {
        timer1.invalidate()
        self.view.isUserInteractionEnabled = false
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refresh), userInfo: nil, repeats: false)
        if optionFour.titleLabel!.text! == correct! {
            optionFour.backgroundColor = UIColor.green
            scoreCount += 1
            streak += 1
            if streak > longestStreak {
                longestStreak = streak
            }
            scoreMaker(scoreCount)
        }
        else {
            optionFour.backgroundColor = UIColor.red
            if streak > longestStreak {
                longestStreak = streak
            }
            streak = 0
        }
        updateStats(correct!, optionFour.titleLabel!.text!, imageView.image!)
    }

    /***********************************************************************************************************/
    /***************************** FUNCTION TO MAKE BUTTONS ****************************************************/
    /***********************************************************************************************************/
    func optionButtonsMaker(_ one: String, _ two: String, _ three: String, _ four: String) {
        // Option 1
        optionOne.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        optionOne.setTitle("\(one)", for: .normal)
        
        // Option 2
        optionTwo.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        optionTwo.setTitle("\(two)", for: .normal)
        
        // OPtion 3
        optionThree.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        optionThree.setTitle("\(three)", for: .normal)
        
        // Option 4
        optionFour.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        optionFour.setTitle("\(four)", for: .normal)
    }
    
    /***********************************************************************************************************/
    /***************************** FUNCTION TO MAKE IMAGES *****************************************************/
    /***********************************************************************************************************/
    
    func imageMaker(_ correctMember: Int) {
        imageView.image = imageArray[correctMember]
        self.view.addSubview(imageView)
    }
    
    /***********************************************************************************************************/
    /***************************** FUNCTION TO MAKE SCORES *****************************************************/
    /***********************************************************************************************************/
    
    func scoreMaker(_ scoreCount: Int) {
        score.textColor = UIColor.gray
        score.text = "Score: \(scoreCount)"
        self.view.addSubview(score)
    }
    
    /***********************************************************************************************************/
    /***************************** RANDOM UTILITY FUNCTIONS ****************************************************/
    /***********************************************************************************************************/
    
    //generates random insertion order
    func insertOrder() -> [Int] {
        
        var insertOrder: [Int] = []
        while insertOrder.count < 4 {
            var insertPos = Int(arc4random_uniform(4))
            while insertOrder.contains(insertPos) {
                insertPos = Int(arc4random_uniform(4))
            }
            insertOrder += [insertPos]
        }
        return insertOrder
    }
    
    //generates 4 random members
    func fourMembers(_ correctMember: Int, _ members: Int) -> [Int] {
        var fourMembers = [correctMember]
        while fourMembers.count < 4 {
            var member = Int(arc4random_uniform(UInt32(members)))
            while fourMembers.contains(member) {
                member = Int(arc4random_uniform(UInt32(members)))
            }
            fourMembers += [member]
        }
        return fourMembers
    }
    
    /***********************************************************************************************************/
    /***************************** FUNCTION TO MAKE SETUP ******************************************************/
    /***********************************************************************************************************/
    func setup() -> Int {
        // generate a random correct member's index
        let correctMember = Int(arc4random_uniform(UInt32(MEMBERS)))
        
        var order = insertOrder()
        var members = fourMembers(correctMember, MEMBERS)
        var count = 0
    
        
        while (count < 4) {
            orderedMembers[order[count]] = members[count]
            count += 1
        }
        
        imageMaker(correctMember)
        let one = nameArray[orderedMembers[0]]
        let two = nameArray[orderedMembers[1]]
        let three = nameArray[orderedMembers[2]]
        let four = nameArray[orderedMembers[3]]
        
        optionButtonsMaker(one, two, three, four)
        
        timer1.invalidate()
        timer1 = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(noChoiceRefresh), userInfo: nil, repeats: true)

        
        return correctMember
    }
    
    @objc func nothing() {
        print("UNPAUSE TO PLAY")
    }
    
    func updateStats(_ name: String, _ choice: String, _ picture:UIImage) {
            lastThreeNames[2] = lastThreeNames[1]
            lastThreeChoices[2] = lastThreeChoices[1]
            lastThreePictures[2] = lastThreePictures[1]
            
            lastThreeNames[1] = lastThreeNames[0]
            lastThreeChoices[1] = lastThreeChoices[0]
            lastThreePictures[1] = lastThreePictures[0]
            
            lastThreeNames[0] = name
            lastThreeChoices[0] = choice
            lastThreePictures[0] = picture
    }
    
    @IBAction func unwindToGame(Segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stats" ) {
            let vc = segue.destination as! StatsViewController
            print(longestStreak)
            print(streak)
            vc.answers = self.lastThreeChoices
            vc.corrects = self.lastThreeNames
            vc.pictures = self.lastThreePictures
            vc.streak = self.longestStreak
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
