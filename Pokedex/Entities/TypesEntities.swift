//
//  TypesEntities.swift
//  Pokedex
//
//  Created by Manuel on 4/7/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import Foundation

struct PokemonType : Codable {
    var name : String?
    var damage_relations : TypeDamageRelations?
    var pokemon : [PokemonOfType]?
}

struct TypeDamageRelations : Codable {
    var double_damage_from : [TypeWeakness]?
    var half_damage_from : [TypeWeakness]?
    var no_damage_from : [TypeWeakness]?
}

struct TypeWeakness : Codable {
    var name : String?
}

struct PokemonOfType : Codable {
    var pokemon : PokemonNameOfType?
    var slot : Int?
}

struct PokemonNameOfType : Codable {
    var name : String?
}

struct PokemonWithType : Codable {
    var pokemonName : String?
    var typeSlot : Int?
    var typeName: String?
}

struct TypeWithWeakness : Codable {
    var typeName : String?
    var typeWeakTo : [WeaknessValue]?
}

struct WeaknessValue : Codable {
    var typeName : String?
    var multiplier : Float?
}
