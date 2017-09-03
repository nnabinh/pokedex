//
//  ViewController.swift
//  pokedex
//
//  Created by Nguyen Ngo An Binh on 2017/08/28.
//  Copyright © 2017 Nguyen Ngo An Binh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    var pokemons: [Pokemon] = []
    var filteredPokemons: [Pokemon] = []
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer?.prepareToPlay()
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]
                self.pokemons.append(Pokemon(name: name!, pokedexId: pokeId))
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            cell.configureCell(inSearchMode ? self.filteredPokemons[indexPath.row] : self.pokemons[indexPath.row])
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = inSearchMode ? filteredPokemons[indexPath.row] : pokemons[indexPath.row]
        performSegue(withIdentifier: "PokemonDetailViewController", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredPokemons.count : pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if (musicPlayer?.isPlaying)! {
            musicPlayer?.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer?.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            filteredPokemons = pokemons.filter({$0.name.range(of: lower) != nil})
        }
        collection.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailViewController" {
            if let detailVC = segue.destination as? PokemonDetailViewController {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }
}

