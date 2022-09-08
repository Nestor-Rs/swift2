//
//  PokeDetalleViewController.swift
//  pjtwo
//
//  Created by Universidad Anahuac on 31/08/22.
//

import UIKit

class PokeDetalleViewController: UIViewController {
    
    var pokemon:Pokemon? = nil

    @IBOutlet weak var nombre: UILabel!
    var imageList : [String] = []
    
    @IBOutlet weak var carrusel: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageList.append("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/132.png")
        imageList.append("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/132.png")
        carrusel.dataSource=self
        carrusel.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imagecell")
        nombre.text=pokemon?.name
        
        loadpokemon()
    }
    
    func loadpokemon(){
        if let pokemon = pokemon {
            let task = URLSession.shared.dataTask(with: URL(string: pokemon.url)!){ data, response, error in
                //let pokemonDetail = try! JSONDecoder().decode(PokemonDetail.self, from: data!)
                //self.loadPokemonImage(urlImage: pokemonDetail.sprites.other.home.front_default)
            }
            task.resume()
        }
    }
    
}

extension PokeDetalleViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath) as?
        ImageCollectionViewCell
        if cell == nil {
            cell = ImageCollectionViewCell()
        }
        let url = imageList[indexPath.row]
        cell?.loadImage(url: url)
        return cell!
    }
}


