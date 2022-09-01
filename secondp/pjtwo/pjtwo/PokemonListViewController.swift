//
//  PokemonListViewController.swift
//  pjtwo
//
//  Created by Universidad Anahuac on 31/08/22.
//PokeDetalles

import UIKit


struct PokemonList: Decodable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [Pokemon]
}

struct Pokemon: Decodable {
    var name: String
    var url: String
}

class PokemonListViewController: UIViewController {

    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var pokemonTableView: UITableView!
    var currentPokemon:Pokemon?=nil
    var pokemons: [Pokemon] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            pokemonTableView.dataSource = self
            loadingIndicatorView.hidesWhenStopped = true
            loadingIndicatorView.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                self.loadPokemons()
            }
            pokemonTableView.dataSource = self
            pokemonTableView.delegate = self
        }
        
        func loadPokemons(){
            let urlBase = "https://pokeapi.co/api/v2/"
            let listPokemonEndPoint = URL.init(string: "\(urlBase)pokemon?limit=100000&offset=0")!
            let task = URLSession.shared.dataTask(with: listPokemonEndPoint){data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let result = try! jsonDecoder.decode(PokemonList.self, from: data)
                    self.pokemons = result.results
                    DispatchQueue.main.sync {
                        self.loadingIndicatorView.stopAnimating()
                        self.pokemonTableView.reloadData()
                    }
                    
                }
            }
            task.resume()
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokeDetalles" {
            let destino = segue.destination as? PokeDetalleViewController
            destino?.pokemon = currentPokemon
        }
    }

    }

    extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pokemons.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = pokemonTableView.dequeueReusableCell(withIdentifier: "cell")
            if(cell == nil){
                cell = UITableViewCell()
            }
            let item = pokemons[indexPath.row]
            cell?.textLabel?.text = item.name
            return cell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            currentPokemon = pokemons[indexPath.row]
            performSegue(withIdentifier: "PokeDetalles", sender: nil)
                
        }


}
