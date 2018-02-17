//
//  TabBarController.swift
//  Pokedex
//
//  Created by Fang on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var pokemonHolder: Pokemon!
    var pokemonImgHolder = [UIImage]()
    var customPurple = UIColor(red: 0.6863, green: 0.2902, blue: 0.698, alpha: 1.0)
    var customPurple2 =  UIColor(red: 0.5176, green: 0.4392, blue: 0.9569, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = customPurple2
        let tab1 = PokemonInfoViewController()
        tab1.pokemonSelected = pokemonHolder
        //if let #imageLiteral(resourceName: "profileIcon")
        let image = UIImage(named: "profileIcon")
        tab1.tabBarItem.image = image
        print("BYYEEEE")
        print(tab1.tabBarItem.image)
//        tab1.pokemonImgs = pokemonImgHolder
        let tab2 = FavoritesViewController()
        
        self.viewControllers = [tab1, tab2]
        
        tab1.tabBarItem = UITabBarItem(title: "PokeFile", image: nil, tag: 0)
        
         //tab1.tabBarItem.image = UIImage(named: "profileIcon")
        
        tab2.tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        
        
        // Do any additional setup after loading the view.
    }

   

}
