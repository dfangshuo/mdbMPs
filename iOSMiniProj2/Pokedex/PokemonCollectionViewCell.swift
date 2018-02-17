//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Fang on 2/14/18.
//  Copyright © 2018 trainingprogram. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    var pokeImageView: UIImageView!
    var button: UIButton!
    var name: UILabel!
    
    override func awakeFromNib() {
        pokeImageView = UIImageView(frame: CGRect(x:22, y:15, width: 77, height:77))
//        pokeImageView.contentMode = .scaleAspectFill
        pokeImageView.layer.cornerRadius = 10
        pokeImageView.clipsToBounds = true
        pokeImageView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(pokeImageView) //remember to add UI elements to the contentView not the cell itself
        
        name = UILabel(frame: CGRect(x:22, y:98, width: 100, height:20))
        name.textColor = UIColor.darkGray
        name.shadowColor = UIColor.gray
        contentView.addSubview(name)
    }
}
