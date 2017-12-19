//
//  ViewController.swift
//  pokedex
//
//  Created by Ahmed Yacoub on 12/12/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
    UISearchBarDelegate
{

    var pokemone = [Pokemon]()          // for collection view
    var filteredPokemon = [Pokemon]()   // for search bar
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.dataSource = self
        collection.delegate   = self
        searchBar.delegate    = self
        
        // 
        searchBar.returnKeyType = UIReturnKeyType.done
        
        // parse CSV file
        parsePokemoneCSV()
        
        // play music automaticly
        initAudio()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var num = 0
        
        if inSearchMode == false {
            num = pokemone.count
        } else {
            num = filteredPokemon.count
        }
        
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCell {

            let poke: Pokemon!
                
            if inSearchMode == false {
                poke = pokemone[indexPath.row]
            } else {
                poke = filteredPokemon[indexPath.row]
            }
            cell.configureCell(pokemon: poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // selecting a pokemon cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemone[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    // return size of the reusable cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    
    // Parse CSV file
    func parsePokemoneCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows     // cast CSV file to an array of arrays
            
            for row in rows {
                let pokeID = Int( row["id"]! )
                let pokeName = row["identifier"]!
                
                // create a Pokemon object
                let poke = Pokemon(name: pokeName, pokedexID: pokeID!)
                
                // append the newly created obj to pokemon array of objects
                pokemone.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    /**
     * Button Music methods
     **/
    
    // On-click music button
    // Toggle music play
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        // if music is playing then pause
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.7
        } else {
            // if music is not playing then play
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    // plays music automaticly
    func initAudio() {
        // Get music.mp3 path
        let musicPath = Bundle.main.path(forResource: "music", ofType: "mp3")!
        let musicURL  = URL(string: musicPath)!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: musicURL)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1         // -1 plays infinite time
            musicPlayer.play()
        } catch let err as NSError {
            print("Music Error: \(err.debugDescription)")
        }
    }
    
    
    /**
     * Search Bar methods
     **/
    
    // Any time a key strok this method will be called - for dynamic search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // search bar is not used
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
        } else {
            
            // user is searching
            inSearchMode = true
            
            let keySearch = searchBar.text!.lowercased()    // lowercase key search
            
            // fetch all objects containing this key
            // $0 - is a placeholder for each object in the array
            filteredPokemon = pokemone.filter( {$0.name.range(of: keySearch) != nil} )
            
            // reload collection view data
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    /**  Segue methods **/
    
    // implement segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailVC" {
            if let detailVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }
}







