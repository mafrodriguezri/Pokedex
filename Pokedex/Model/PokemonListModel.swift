//
//  PokemonListModel.swift
//  Pokedex
//
//  Created by Manuel on 4/7/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PokemonListModel {
    let baseUrl = "https://pokeapi.co/api/v2/pokemon"
    var delegate : PokemonListModelDelegate?
    var pokemonListArray : [ListPokemonEntity] = []
    
//MARK: - Get the pokemon list for a page
    func getPokemonList(page: Int, limit: Int = pageSize) {
        Alamofire.request(baseUrl, parameters: ["offset":"\(page)","limit":"\(limit)"]) .responseJSON { (response) in
            if response.result.isSuccess, let value = response.result.value {
                let listJSON = JSON(value)
                guard let _ = listJSON["results"][0]["name"].string else { self.delegate?.failureGetList(); return }
                self.parsePokemonList(listJSON: listJSON, initId: page + 1)
            } else {
                print("Error getting Pokemon List: \(String(describing: response.result.error))")
                self.delegate?.failureGetList()
            }
        }
    }
//MARK: - parse the pokemon list for a page
    func parsePokemonList(listJSON: JSON, initId: Int){
        pokemonListArray.removeAll()
        let listCount = listJSON["results"].count
        for i in 0..<listCount {
            var newListPokemon = ListPokemonEntity()
            newListPokemon.name = listJSON["results"][i]["name"].stringValue
            newListPokemon.idNumber = i + initId
            pokemonListArray.append(newListPokemon)
        }
        delegate?.successGetList(list: pokemonListArray)
    }
}

protocol PokemonListModelDelegate {
    func successGetList(list: [ListPokemonEntity])
    func failureGetList()
}
