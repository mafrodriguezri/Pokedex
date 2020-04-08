//
//  PokemonDetailModel.swift
//  Pokedex
//
//  Created by Manuel on 4/7/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import Foundation
import Alamofire

class PokemonDetailModel {
    let baseUrl = "https://pokeapi.co/api/v2/pokemon"
    let group = DispatchGroup()
    var delegate : PokemonDetailModelDelegate?
    var pokemonId : Int = 0
    var pokemonData = PokemonDataEntity()
    var pokemonSpeciesData = PokemonSpeciesDataEntity()
    var pokemonDetails = PokemonDetailEntity()
    
    func getPokemonDetails() {
        getPokemonData()
        getPokemonSpeciesData()
        group.notify(queue: .main) {
            self.fillPokemonDetails()
        }
    }
//MARK: - get the Pokémon data
    func getPokemonData() {
        group.enter()
        Alamofire.request(baseUrl + "/\(pokemonId)").responseJSON { (response) in
            if response.result.isSuccess, let data = response.data {
                self.decodePokemonData(data: data)
            } else {
                self.group.leave()
                print("Error getting Pokemon data: \(String(describing: response.result.error))")
            }
        }
    }
//MARK: - get the Pokémon species data
    func getPokemonSpeciesData() {
        group.enter()
        Alamofire.request(baseUrl + "-species/\(pokemonId)").responseJSON { (response) in
            if response.result.isSuccess, let speciesData = response.data {
                self.decodePokemonSpeciesData(speciesData: speciesData)
            } else {
                self.group.leave()
                print("Error getting Pokemon species data: \(String(describing: response.result.error))")
            }
        }
    }
//MARK: - decode the Pokémon data
    func decodePokemonData(data: Data) {
        do {
            let pokemonDataDecoded = try JSONDecoder().decode(PokemonDataEntity.self, from: data)
            pokemonData = pokemonDataDecoded
        } catch {
            print("Error decoding Pokemon data")
        }
        self.group.leave()
    }
//MARK: - decode the Pokémon species data
    func decodePokemonSpeciesData(speciesData: Data) {
        do {
            let pokemonSpeciesDataDecoded = try JSONDecoder().decode(PokemonSpeciesDataEntity.self, from: speciesData)
            pokemonSpeciesData = pokemonSpeciesDataDecoded
        } catch {
            print("Error decoding Pokemon species data")
        }
        self.group.leave()
    }
//MARK: - fill Pokemon details
    func fillPokemonDetails() {
        if pokemonData.abilities?.first?.ability?.name != nil, pokemonSpeciesData.flavor_text_entries?.first?.language?.name != nil {
            pokemonDetails.name = pokemonData.species?.name
            let apiDescrption = pokemonSpeciesData.flavor_text_entries?.first(where: {$0.language?.name == "en"})?.flavor_text ?? ""
            pokemonDetails.description = apiDescrption.replacingOccurrences(of: "\n", with: " ")
            let stats = PokemonStatsEntity(hp: pokemonData.stats?.first(where: {$0.stat?.name == "hp"})?.base_stat,
                                           attack: pokemonData.stats?.first(where: {$0.stat?.name == "attack"})?.base_stat,
                                           defense: pokemonData.stats?.first(where: {$0.stat?.name == "defense"})?.base_stat,
                                           spAttack: pokemonData.stats?.first(where: {$0.stat?.name == "special-attack"})?.base_stat,
                                           spDefense: pokemonData.stats?.first(where: {$0.stat?.name == "special-defense"})?.base_stat,
                                           speed: pokemonData.stats?.first(where: {$0.stat?.name == "speed"})?.base_stat)
            pokemonDetails.stats = stats
            let abilities = PokemonAbilitiesEntity(ability1Name: pokemonData.abilities?.first(where: {$0.slot == 1})?.ability?.name,
                                                   ability1Description: nil,
                                                   ability2Name: pokemonData.abilities?.first(where: {$0.slot == 2})?.ability?.name,
                                                   ability2Description: nil,
                                                   abilityHiddenName: pokemonData.abilities?.first(where: {$0.is_hidden == true})?.ability?.name,
                                                   abilityHiddenDescription: nil)
            pokemonDetails.abilities = abilities
            let eggGroups = pokemonSpeciesData.egg_groups ?? []
            pokemonDetails.eggGroups = eggGroups.map{$0.name ?? ""}
            pokemonDetails.hatchSteps = (pokemonSpeciesData.hatch_counter ?? 0) * 255
            pokemonDetails.hatchCycles = pokemonSpeciesData.hatch_counter
            pokemonDetails.femaleRate = 100 * (Float(pokemonSpeciesData.gender_rate ?? 0) / 8)
            pokemonDetails.habitat = pokemonSpeciesData.habitat?.name
            let genNumber = ((pokemonSpeciesData.generation?.name ?? "").components(separatedBy: "-").last ?? "").uppercased()
            pokemonDetails.generation = genNumber
            pokemonDetails.captureRate = pokemonSpeciesData.capture_rate
            pokemonDetails.spriteStandardUrl = pokemonData.sprites?.front_default
            pokemonDetails.spriteShinyUrl = pokemonData.sprites?.front_shiny
            delegate?.successGetDetails(details: pokemonDetails)
        } else {
            delegate?.failureGetDetails()
        }
    }
}

protocol PokemonDetailModelDelegate {
    func successGetDetails(details: PokemonDetailEntity)
    func failureGetDetails()
}
