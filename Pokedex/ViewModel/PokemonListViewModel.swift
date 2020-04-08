//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Manuel on 4/7/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import Foundation

class PokemonListViewModel {
    let model = PokemonListModel()
    var delegate : PokemonListViewModelDelegate?
    var page : Int = 0 {
        didSet {
            getPokemonListPage(page: page * pageSize)
        }
    }
    var pokemonListArray : [ListPokemonEntity] = []
    
    func getPokemonListPage(page: Int) {
        model.delegate = self
        if pokemonListArray.count < 800 {
            model.getPokemonList(page: page)
        } else if pokemonListArray.count == 800 {
            model.getPokemonList(page: page, limit: 7)
        }
    }
}

extension PokemonListViewModel : PokemonListModelDelegate{
    func successGetList(list: [ListPokemonEntity]) {
        pokemonListArray.append(contentsOf: list)
        delegate?.successGetPokemonList()
    }
    
    func failureGetList() {
        delegate?.failureGetPokemonList()
    }
}

protocol PokemonListViewModelDelegate {
    func successGetPokemonList()
    func failureGetPokemonList()
}
