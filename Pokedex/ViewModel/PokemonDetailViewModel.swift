//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Manuel on 4/7/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import Foundation

class PokemonDetailViewModel {
    let model = PokemonDetailModel()
    var delegate : PokemonDetailViewModelDelegate?
    var pokemonDetail : PokemonDetailEntity?
    
    func getPokemonDetails(id: Int) {
        model.delegate = self
        model.pokemonId = id
        model.getPokemonDetails()
    }
}

extension PokemonDetailViewModel : PokemonDetailModelDelegate {
    func successGetDetails(details: PokemonDetailEntity) {
        pokemonDetail = details
        delegate?.successGetPokemonDetail()
    }
    
    func failureGetDetails() {
        delegate?.failureGetPokemonDetail()
    }
}

protocol PokemonDetailViewModelDelegate {
    func successGetPokemonDetail()
    func failureGetPokemonDetail()
}
