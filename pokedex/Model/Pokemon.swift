//
//  Pokemon.swift
//  pokedex
//
//  Created by Nguyen Ngo An Binh on 2017/08/28.
//  Copyright © 2017 Nguyen Ngo An Binh. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
