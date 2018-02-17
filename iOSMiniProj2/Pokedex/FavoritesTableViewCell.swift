//
//  FavoritesTableViewCell.swift
//  Pokedex
//
//  Created by Shubham Gupta on 2/15/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    var pokeImageView: UIImageView!
    //var button: UIButton!
    var name: UILabel!
    
    override func awakeFromNib() {
        pokeImageView = UIImageView(frame: CGRect(x:120, y:15, width: 77, height:77))
        pokeImageView.contentMode = .scaleAspectFit
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
        
        name = UILabel(frame: CGRect(x:20, y:80, width: 120, height:40))
        name.textColor = UIColor.gray
        name.shadowColor = UIColor.gray
        contentView.addSubview(name)
    }

}
