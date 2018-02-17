//
//  ViewController.swift
//  Match the Members!
//
//  Created by Fang on 2/7/18.
//  Copyright © 2018 fang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startButton: UIButton!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(frame: CGRect(x: (view.frame.width-260)/2, y: 185, width: 260, height: 260))
        imageView.image = #imageLiteral(resourceName: "MDB Cover")
        view.addSubview(imageView)

        // Start Button
        startButton = UIButton(frame: CGRect(x: 20, y: 525, width: view.frame.width - 40, height: 60))
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        startButton.backgroundColor = UIColor(red: 0.57, green: 0.85, blue: 0.95, alpha: 0.9)
        startButton.setTitle("Start", for: .normal)
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(toMain), for: .touchUpInside)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toMain(_ sender: Any) {
        self.performSegue(withIdentifier: "start", sender: sender)
    }
    
}



