//
//  PokemonTypesModel.swift
//  Pokedex
//
//  Created by Manuel on 4/7/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import Foundation
import Alamofire

class PokemonTypesModel {
    //URL to persist the Pokémon types data
    let dataFilePathPokemonTypes = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("PokemonTypes.json")
    let baseUrl = "https://pokeapi.co/api/v2/type/" //baseURL for the API request
    let group = DispatchGroup()
    var delegate : PokemonTypesModelDelegate?
    var pokemonTypesArray : [PokemonType] = []
    
//MARK: - check if the types data is persisted
    func retrievePokemonTypesData() {
        do {
            let persistedData = try? Data(contentsOf: dataFilePathPokemonTypes!)
            pokemonTypesArray = persistedData != nil ? try JSONDecoder().decode([PokemonType].self, from: persistedData!) : []
            _ = pokemonTypesArray.count == 18 ? delegate?.successGetTypes(pokemonTypesInfo: pokemonTypesArray) : cyclePokemonTypes()
        } catch {
            cyclePokemonTypes()
        }
    }
    
//MARK: - cycle through the 18 types id
    func cyclePokemonTypes() {
        pokemonTypesArray.removeAll()
        for typeId in 1...18 {
            getPokemonType(typeId: "\(typeId)")
        }
        group.notify(queue: .main) {
            self.persistPokemonTypes()
        }
    }
//MARK: - get Pokémon type data for an type id
    func getPokemonType(typeId: String) {
        group.enter()
        Alamofire.request(baseUrl + typeId).responseJSON { (response) in
            if response.result.isSuccess, let data = response.data {
                self.decodePokemonType(typeData: data)
            } else {
                self.group.leave()
                print("Error getting PokemonTypes: \(String(describing: response.result.error))")
            }
        }
    }
//MARK: - decode the Pokémon types data
    func decodePokemonType(typeData: Data) {
        do {
            let pokemonType = try JSONDecoder().decode(PokemonType.self, from: typeData)
            pokemonTypesArray.append(pokemonType)
        } catch {
            print("Error decoding types data")
        }
        group.leave()
    }
//MARK: - persist the Pokémon types data
    func persistPokemonTypes() {
        do {
            let typesData = try JSONEncoder().encode(pokemonTypesArray)
            try typesData.write(to: dataFilePathPokemonTypes!)
            _ = pokemonTypesArray.count == 18 ? delegate?.successGetTypes(pokemonTypesInfo: pokemonTypesArray) : delegate?.failureGetTypes()
        } catch {
            print("Error persisting types data")
            delegate?.failureGetTypes()
        }
    }
}

protocol PokemonTypesModelDelegate {
    func successGetTypes(pokemonTypesInfo: [PokemonType])
    func failureGetTypes()
}
