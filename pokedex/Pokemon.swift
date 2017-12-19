//
//  Pokemon.swift
//  pokedex
//
//  Created by Ahmed Yacoub on 12/12/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import Foundation

class Pokemon {
    
    // Properties
    private var _name: String
    private var _pokedexID: Int
    
    
    // Getters
    var name: String {
        
        return _name
    }
    
    var pokedexID: Int {
        
        return _pokedexID
    }
    
    
    // Constructor - Intializer
    init (name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
    }
}
