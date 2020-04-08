//
//  PokemonTypesViewModel.swift
//  Pokedex
//
//  Created by Manuel on 4/7/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import Foundation

class PokemonTypesViewModel {
    let model = PokemonTypesModel()
    var delegate : PokemonTypesViewModelDelegate?
    var pokemonTypesArray : [PokemonType] = []
    var pokemonWithType : [PokemonWithType] = []
    
    func getPokemonTypes() {
        model.delegate = self
        model.retrievePokemonTypesData()
    }
    
    func filterPokemonByType() {
        for pokemonType in pokemonTypesArray {
            let pokemonOfType = pokemonType.pokemon ?? []
            for pokemon in pokemonOfType {
                var pokemonToAppend = PokemonWithType()
                pokemonToAppend.pokemonName = pokemon.pokemon?.name
                pokemonToAppend.typeSlot = pokemon.slot
                pokemonToAppend.typeName = pokemonType.name
                pokemonWithType.append(pokemonToAppend)
            }
        }
        delegate?.successGetPokemonTypes()
    }
}

extension PokemonTypesViewModel : PokemonTypesModelDelegate {
    
    func successGetTypes(pokemonTypesInfo: [PokemonType]) {
        pokemonTypesArray = pokemonTypesInfo
        filterPokemonByType()
    }
    
    func failureGetTypes() {
        delegate?.failureGetPokemonTypes()
    }
}

protocol PokemonTypesViewModelDelegate {
    func successGetPokemonTypes()
    func failureGetPokemonTypes()
}
