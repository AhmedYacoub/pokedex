//
//  PokeCell.swift
//  pokedex
//
//  Created by Ahmed Yacoub on 12/13/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeLbl: UILabel!
    
    var pokemon: Pokemon!
    
    // Populate cell
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokeLbl.text = self.pokemon.name.capitalized
        pokeImg.image = UIImage( named: "\(self.pokemon.pokedexID)" )
    }
    
    
    // Set cell corners to be round by 5
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
}
