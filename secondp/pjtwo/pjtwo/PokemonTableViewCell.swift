//
//  PokemonTableViewCell.swift
//  pjtwo
//
//  Created by Universidad Anahuac on 05/09/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func setupView(pokemon:Pokemon){
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        self.texto.text=pokemon.name
        loadpokemon(pokemon: pokemon)
    }
    
    func loadpokemon(pokemon:Pokemon){
        self.imagen.isHidden=true
        self.indicator.startAnimating()
            let task = URLSession.shared.dataTask(with: URL(string: pokemon.url)!){ data, response, error in
                let pokemonDetail = try! JSONDecoder().decode(PokemonDetail.self, from: data!)
                self.loadPokemonImage(urlImage: pokemonDetail.sprites.other.home.front_default)
                
            }
            task.resume()
    }
    
    func loadPokemonImage(urlImage:String){
        let task = URLSession.shared.dataTask(with: URL(string: urlImage)!){ data, response, error in
            if let data = data {
                let image = UIImage.init(data: data)
                DispatchQueue.main.sync {
                    self.imagen.image = image
                    self.indicator.stopAnimating()
                    self.imagen.isHidden=false
                }
            }
            
        }
        task.resume()
    }
    
}
