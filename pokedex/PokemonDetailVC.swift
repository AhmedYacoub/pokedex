//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Ahmed Yacoub on 12/16/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonImg.image = UIImage(named: "\(pokemon.pokedexID)")
        pokemonName.text = pokemon.name.capitalized
    }


    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
