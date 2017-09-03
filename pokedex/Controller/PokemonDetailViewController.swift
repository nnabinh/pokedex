//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Nguyen Ngo An Binh on 2017/09/04.
//  Copyright © 2017 Nguyen Ngo An Binh. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
    }
}
