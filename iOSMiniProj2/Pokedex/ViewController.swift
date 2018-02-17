//
//  ViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Pokemon Title
    var titleLabel: UILabel!
    
    // Input Constraint Fields
    var searchField: UITextField!
    var minAtkTextField: UITextField!
    var minDefTextField: UITextField!
    var minHpTextField: UITextField!
    
    // Variables
    var pokeName: String!
    var minAtk: Int!
    var minDef: Int!
    var minHp: Int!
    
    // Search Button
    var search: UIButton!
    var randomSearch: UIButton!
    var randomOrNot = false
    
    // ScrollView
    var scView:UIScrollView!
    let buttonPadding:CGFloat = 10
    var xOffset:CGFloat = 10
    var typesSelected = Set<String>()
    
    var customPurple = UIColor(red: 0.6863, green: 0.2902, blue: 0.698, alpha: 1.0)
    var customPurple2 =  UIColor(red: 0.5176, green: 0.4392, blue: 0.9569, alpha: 1.0)
    
    // pokemon list
    var pokemonList = PokemonGenerator.getPokemonArray()
    var pok = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // page setup
        titleLabel = UILabel(frame: CGRect(x: 0, y: 40, width: view.bounds.width, height: 120))
        titleLabel.text = "Pokédex"
        titleLabel.font = titleLabel.font.withSize(90)
        titleLabel.textColor = customPurple2
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        //scroll view
        scView = UIScrollView(frame: CGRect(x: 0, y: 250, width: view.bounds.width, height: 70))
        view.addSubview(scView)
        
        scView.translatesAutoresizingMaskIntoConstraints = false
        
        // adding type into buttons
        for type in types {
            let button = UIButton()
            button.setTitle(type, for: .normal)
            button.backgroundColor = UIColor.darkGray
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.setTitle("\(type)", for: .normal)
            button.tag = types.index(of: type)!
            button.addTarget(self, action: #selector(typeSelect), for: .touchUpInside)
            
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 80, height: 50)
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            scView.addSubview(button)
            
            
        }
        
        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
        
        searchField = UITextField(frame: CGRect(x: 20, y: 190, width: view.frame.width - 40, height: 50))
        searchField.placeholder = "Pokémon Name/Number"
        searchField.borderStyle = .roundedRect
        searchField.clipsToBounds = true
        view.addSubview(searchField)
        
        minAtkTextField = UITextField(frame: CGRect(x: 20, y: 340, width: view.frame.width - 40, height: 50))
        minAtkTextField.placeholder = "Minimum Attack Points"
        minAtkTextField.borderStyle = .roundedRect
        minAtkTextField.clipsToBounds = true
        view.addSubview(minAtkTextField)
        
        minDefTextField = UITextField(frame: CGRect(x: 20, y: 420, width: view.frame.width - 40, height: 50))
        minDefTextField.placeholder = "Minimum Defense Points"
        minDefTextField.borderStyle = .roundedRect
        minDefTextField.clipsToBounds = true
        view.addSubview(minDefTextField)
        
        minHpTextField = UITextField(frame: CGRect(x: 20, y: 500, width: view.frame.width - 40, height: 50))
        minHpTextField.placeholder = "Minimum Health Points"
        minHpTextField.borderStyle = .roundedRect
        minHpTextField.clipsToBounds = true
        view.addSubview(minHpTextField)
        
        search = UIButton(frame: CGRect(x: 20, y: 570, width: view.frame.width - 40, height: 50))
        search.backgroundColor = customPurple2
        search.layer.cornerRadius = 15
        search.setTitle("Search!", for: .normal)
        view.addSubview(search)
        search.addTarget(self, action: #selector(toSearch), for: .touchUpInside)
        
        randomSearch = UIButton(frame: CGRect(x: 20, y: 630, width: view.frame.width - 40, height: 50))
        randomSearch.backgroundColor = customPurple2
        randomSearch.layer.cornerRadius = 15
        randomSearch.setTitle("Featured Pokémon", for: .normal)
        view.addSubview(randomSearch)
        randomSearch.addTarget(self, action: #selector(toSearch), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true;
    }
    
    override func loadView() {
        view = UIView()
        view.frame = UIScreen.main.bounds
        setBackground()
    }
    
    func setBackground() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "pokeBackground.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func readInputs() {
        if let name = searchField.text {
            pokeName = name
        }
        if let attack = minAtkTextField.text {
            if attack != "" {
                if let attack = Int(attack) {
                    minAtk = Int(attack)
                } else {
                    raiseInvalidTypeAlert(info: "Attack")
                }
            } else {
                minAtk = 0
            }
        }
        if let defense = minDefTextField.text {
            if defense != "" {
                if let defense = Int(defense) {
                    minDef = Int(defense)
                } else {
                    raiseInvalidTypeAlert(info: "Defense")
                }
            }
            else {
                minDef = 0
            }
        }
        if let hp = minHpTextField.text {
            if hp != "" {
                if let hp = Int(hp) {
                    minHp = Int(hp)
                } else {
                    raiseInvalidTypeAlert(info: "Hitpoint")
                }
            }
            else {
                minHp = 0
            }
        }
    }
    
    func raiseInvalidTypeAlert(info: String) {
        let alert = UIAlertController(title: "Invalid \(info) Information", message: "Please enter intger values for this field", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearch" {
            if randomOrNot {
                if let destinationVC = segue.destination as? ListViewController {
                    let randomPokemons = generateRandomPokemon()
                    destinationVC.filteredPokemonInfo = randomPokemons
                    destinationVC.randomlyGenerated = true
                }
            }
            else {
                if let destinationVC = segue.destination as? ListViewController {
                    destinationVC.name = pokeName
                    destinationVC.pokeType = typesSelected
                    destinationVC.atk = minAtk
                    destinationVC.def = minDef
                    destinationVC.hp = minHp
                }
            }
        }
        
        if segue.identifier == "fastTrack" {
            let VC = segue.destination as! TabBarController
            VC.pokemonHolder = pok[0]
        }
    }
    
    @objc func toSearch (_ sender: UIButton) {
        if sender.titleLabel?.text == "Featured Pokémon" {
            randomOrNot = true
        } else {
            randomOrNot = false
        }
        readInputs()
        if minAtk == 0 && minDef == 0 && minHp == 0 && typesSelected.isEmpty {
            for poke in pokemonList {
                if pokeName == poke.name || Int(pokeName) == poke.number {
                    print("i came hee")
                    pok = [poke]
                    self.performSegue(withIdentifier: "fastTrack", sender: sender)
                    return
                }
            }
        }
        self.performSegue(withIdentifier: "toSearch", sender: sender)
    }
    
//    @objc func searchRandomly() {
//
//        self.performSegue(withIdentifier: "toSearch", sender: Any?.self)
//    }
    @objc func typeSelect(sender: UIButton) {
        
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
        
        let tag = sender.tag
        let type = tagToType(tagNumber: tag)
        if typesSelected.contains(type) {
            typesSelected.remove(type)
            sender.backgroundColor = .darkGray
        } else {
            typesSelected.insert(type)
            sender.backgroundColor = customPurple
        }
        print(typesSelected)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

