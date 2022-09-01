//
//  PokeDetalleViewController.swift
//  pjtwo
//
//  Created by Universidad Anahuac on 31/08/22.
//

import UIKit

class PokeDetalleViewController: UIViewController {
    
    var pokemon:Pokemon? = nil
    
    struct PokemonDetail : Decodable{
        var sprites:pokemonDetailSprite
    }
    
    struct pokemonDetailHome:Decodable{
        var front_default: String
    }
    
    struct pokemonDetailOther:Decodable{
        var home : pokemonDetailHome
    }
    
    struct pokemonDetailSprite:Decodable{
        var other : pokemonDetailOther
    }

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var sprite: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombre.text=pokemon?.name
        loadpokemon()
    }
    
    func loadpokemon(){
        if let pokemon = pokemon {
            let task = URLSession.shared.dataTask(with: URL(string: pokemon.url)!){ data, response, error in
                let pokemonDetail = try! JSONDecoder().decode(PokemonDetail.self, from: data!)
                self.loadPokemonImage(urlImage: pokemonDetail.sprites.other.home.front_default)
            }
            task.resume()
        }
    }
    
    func loadPokemonImage(urlImage:String){
        let task = URLSession.shared.dataTask(with: URL(string: urlImage)!){ data, response, error in
            if let data = data {
                let image = UIImage.init(data: data)
                DispatchQueue.main.sync {
                    self.sprite.image = image
                }
            }
            
        }
        task.resume()
    }
    
}
