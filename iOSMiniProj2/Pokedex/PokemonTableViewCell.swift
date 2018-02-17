//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Fang on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    var pokeImageView: UIImageView!
    var button: UIButton!
    var name: UILabel!
    var num: UILabel!
    
    override func awakeFromNib() {
        pokeImageView = UIImageView(frame: CGRect(x:20, y:15, width: 77, height:77))
        pokeImageView.layer.cornerRadius = 10
        pokeImageView.clipsToBounds = true
        pokeImageView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(pokeImageView) //remember to add UI elements to the contentView not the cell itself
        
        //        button = UIButton(frame: CGRect(x:20, y:15, width: 100, height:100))
        //        button.layer.cornerRadius = 10
        //        button.clipsToBounds = true
        //        button.tag = 34
        //        button.addTarget(self, action: #selector(toProfile), for: .touchUpInside)
        //        contentView.addSubview(button)
        
        name = UILabel(frame: CGRect(x:125, y:25, width: 240, height:30))
        name.textColor = UIColor.black
        name.font = UIFont.boldSystemFont(ofSize: 25)
        contentView.addSubview(name)
        
        num = UILabel(frame: CGRect(x:125, y:55, width: 200, height:30))
        num.textColor = UIColor.darkGray
        contentView.addSubview(num)
    }
}
