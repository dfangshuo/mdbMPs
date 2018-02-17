//
//  Pokemon.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import Foundation
import UIKit

var types = ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy",
             "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water"]
var pokemonList = PokemonGenerator.getPokemonArray()

var favoritePokemon = [Pokemon]()

func generateRandomPokemon() -> [Pokemon] {
    var randomPokemons = [Pokemon]()
    for _ in 1...20 {
        let randomIndex = Int(arc4random_uniform(UInt32(pokemonList.count - 1)))
        randomPokemons.append(pokemonList[randomIndex])
    }
    return randomPokemons
}

func getPokeName(pokeNumber: Int, pokeList: [Pokemon]) -> Pokemon? {
    for pokemon in pokeList {
        if pokemon.number == pokeNumber {
            return pokemon
        }
    }
    return nil
}

func tagToType(tagNumber:Int) -> String {
    return types[tagNumber]
}

func getImageFromURL(imageUrl: String) -> UIImage {
    let url = URL(string: imageUrl)
    if url != nil{
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
            
        }
        catch _{
            print("Error getting image")
            return UIImage(named: "error")!
        }
    }
    else{
        print("Broken URL")
        return UIImage(named: "error")!
    }
}
    

class Pokemon {
    
    /* Note 1: 
       There are 18 different types of Pokemon, and a single Pokemon can inherit multiple types:
            Bug, Grass, Dark, Ground, Dragon, Ice, Electric, Normal, Fairy,
            Poison, Fighting, Psychic, Fire, Rock, Flying, Steel, Ghost, Water
    */
    
    /* Note 2:
       The image for each Pokemon is not provided, but a URL is. You should look up how to get an image from it's URL.
    */
    
    /* Note 3:
       You can access the properties of Pokemon using dot notation (e.g. pokemon.name, pokemon.number, etc.)
     */
 
    let name: String!
    let number: Int!
    let attack: Int!
    let defense: Int!
    let health: Int!
    let specialAttack: Int!
    let specialDefense: Int!
    let species: String!
    let speed: Int!
    let total: Int!
    let types: [String]
    let imageUrl: String!
    
    
    init(name: String, number: Int, attack: Int, defense: Int, health: Int, spAttack: Int, spDef: Int, species: String, speed: Int, total: Int, types: [String]) {
        self.name = name
        self.number = number
        self.attack = attack
        self.defense = defense
        self.health = health
        self.specialAttack = spAttack
        self.specialDefense = spDef
        self.species = species
        self.speed = speed
        self.total = total
        self.types = types
        self.imageUrl = "http://img.pokemondb.net/artwork/\(name.components(separatedBy: " ")[0].lowercased()).jpg"
    }
    
    func getImageFromURL() -> UIImage {
        let url = URL(string: self.imageUrl)
        if url != nil{
            do {
                let data = try Data(contentsOf: url!)
                return UIImage(data: data)!
                
            }
            catch _{
                print("Error getting image")
                return UIImage(named: "error")!
            }
        }
        else{
            print("Broken URL")
            return UIImage(named: "error")!
        }
    }
    
    
}
