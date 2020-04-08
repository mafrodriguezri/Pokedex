//
//  PokemonEntity.swift
//  Pokedex
//
//  Created by Manuel on 4/6/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import Foundation

struct ListPokemonEntity : Codable {
    var name : String?
    var idNumber : Int?
}

struct PokemonDetailEntity : Codable {
    var name : String?
    var description : String?
    var stats : PokemonStatsEntity?
    var abilities : PokemonAbilitiesEntity?
    var eggGroups : [String]?
    var hatchSteps : Int?
    var hatchCycles : Int?
    var femaleRate : Float?
    var habitat : String?
    var generation : String?
    var captureRate : Int?
    var spriteStandardUrl : String?
    var spriteShinyUrl : String?
}

struct PokemonStatsEntity : Codable {
    var hp : Int?
    var attack : Int?
    var defense : Int?
    var spAttack : Int?
    var spDefense : Int?
    var speed : Int?
}

struct PokemonAbilitiesEntity : Codable {
    var ability1Name : String?
    var ability1Description : String?
    var ability2Name : String?
    var ability2Description : String?
    var abilityHiddenName : String?
    var abilityHiddenDescription : String?
}

struct PokemonDataEntity : Codable {
    var abilities : [AbilityData]?
    var species : SpeciesData?
    var sprites : SpritesData?
    var stats : [StatData]?
}

struct AbilityData : Codable {
    var ability : AbilityDataName?
    var is_hidden : Bool?
    var slot : Int?
}

struct AbilityDataName : Codable {
    var name : String?
    var url : String?
}

struct SpeciesData : Codable {
    var name : String?
}

struct SpritesData : Codable {
    var front_default : String?
    var front_shiny : String?
}

struct StatData : Codable {
    var base_stat : Int?
    var stat : StatDataName?
}

struct StatDataName : Codable {
    var name : String?
}

struct PokemonSpeciesDataEntity : Codable {
    var capture_rate : Int?
    var egg_groups : [EggGroupData]?
    var gender_rate : Int?
    var generation : GenerationData?
    var habitat : HabitatData?
    var hatch_counter : Int?
    var flavor_text_entries : [FlavorTextData]?
}

struct EggGroupData : Codable {
    var name : String?
}

struct GenerationData : Codable {
    var name : String?
}

struct HabitatData : Codable {
    var name : String?
}

struct FlavorTextData : Codable {
    var flavor_text : String?
    var language : LanguageData?
}

struct LanguageData : Codable {
    var name : String?
}
