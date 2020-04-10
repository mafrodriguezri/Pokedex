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
    var typesWithWeaknesses : [TypeWithWeakness] = []
    
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
        createWeaknessesArray()
    }
    
    func createWeaknessesArray() {
        for pokemonType in pokemonTypesArray {
            var typeWithWeakness = TypeWithWeakness()
            var typeWeakTo : [WeaknessValue] = []
            let noDamageFromTypes = (pokemonType.damage_relations?.no_damage_from ?? []).map{$0.name ?? ""}
            let halfDamageFromTypes = (pokemonType.damage_relations?.half_damage_from ?? []).map{$0.name ?? ""}
            let doubleDamageFromTypes = (pokemonType.damage_relations?.double_damage_from ?? []).map{$0.name ?? ""}
            for typeWeakness in noDamageFromTypes {
                typeWeakTo.append(WeaknessValue(typeName: typeWeakness, multiplier: 0))
            }
            for typeWeakness in halfDamageFromTypes {
                typeWeakTo.append(WeaknessValue(typeName: typeWeakness, multiplier: 0.5))
            }
            for typeWeakness in doubleDamageFromTypes {
                typeWeakTo.append(WeaknessValue(typeName: typeWeakness, multiplier: 2))
            }
            typeWithWeakness.typeName = pokemonType.name
            typeWithWeakness.typeWeakTo = typeWeakTo
            typesWithWeaknesses.append(typeWithWeakness)
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
