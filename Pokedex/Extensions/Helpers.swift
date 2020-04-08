//
//  Helpers.swift
//  Pokedex
//
//  Created by Manuel on 4/6/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import Foundation
import UIKit

enum type : String {
    case bug = "bug"
    case dark = "dark"
    case dragon = "dragon"
    case electric = "electric"
    case fairy = "fairy"
    case fighting = "fighting"
    case fire = "fire"
    case flying = "flying"
    case ghost = "ghost"
    case grass = "grass"
    case ground = "ground"
    case ice = "ice"
    case normal = "normal"
    case poison = "poison"
    case psychic = "psychic"
    case rock = "rock"
    case steel = "steel"
    case water = "water"
}

enum typeTag : String {
    case bugTag = "BugTag"
    case darkTag = "DarkTag"
    case dragonTag = "DragonTag"
    case electricTag = "ElectricTag"
    case fairyTag = "FairyTag"
    case fightingTag = "FightingTag"
    case fireTag = "FireTag"
    case flyingTag = "FlyingTag"
    case ghostTag = "GhostTag"
    case grassTag = "GrassTag"
    case groundTag = "GroundTag"
    case iceTag = "IceTag"
    case normalTag = "NormalTag"
    case poisonTag = "PoisonTag"
    case psychicTag = "PsychicTag"
    case rockTag = "RockTag"
    case steelTag = "SteelTag"
    case waterTag = "WaterTag"
}

enum typeBackground : String {
    case bugBackground = "BugBackground"
    case darkBackground = "DarkBackground"
    case dragonBackground = "DragonBackground"
    case electricBackground = "ElectricBackground"
    case fairyBackground = "FairyBackground"
    case fightingBackground = "FightingBackground"
    case fireBackground = "FireBackground"
    case flyingBackground = "FlyingBackground"
    case ghostBackground = "GhostBackground"
    case grassBackground = "GrassBackground"
    case groundBackground = "GroundBackground"
    case iceBackground = "IceBackground"
    case normalBackground = "NormalBackground"
    case poisonBackground = "PoisonBackground"
    case psychicBackground = "PsychicBackground"
    case rockBackground = "RockBackground"
    case steelBackground = "SteelBackground"
    case waterBackground = "WaterBackground"
}

func getDetailBackground(pokemonType: String) -> String{
    switch pokemonType {
    case type.bug.rawValue:
        return typeBackground.bugBackground.rawValue
    case type.dark.rawValue:
        return typeBackground.darkBackground.rawValue
    case type.dragon.rawValue:
        return typeBackground.dragonBackground.rawValue
    case type.electric.rawValue:
        return typeBackground.electricBackground.rawValue
    case type.fairy.rawValue:
        return typeBackground.fairyBackground.rawValue
    case type.fighting.rawValue:
        return typeBackground.fightingBackground.rawValue
    case type.fire.rawValue:
        return typeBackground.fireBackground.rawValue
    case type.flying.rawValue:
        return typeBackground.flyingBackground.rawValue
    case type.ghost.rawValue:
        return typeBackground.ghostBackground.rawValue
    case type.grass.rawValue:
        return typeBackground.grassBackground.rawValue
    case type.ground.rawValue:
        return typeBackground.groundBackground.rawValue
    case type.ice.rawValue:
        return typeBackground.iceBackground.rawValue
    case type.normal.rawValue:
        return typeBackground.normalBackground.rawValue
    case type.poison.rawValue:
        return typeBackground.poisonBackground.rawValue
    case type.psychic.rawValue:
        return typeBackground.psychicBackground.rawValue
    case type.rock.rawValue:
        return typeBackground.rockBackground.rawValue
    case type.steel.rawValue:
        return typeBackground.steelBackground.rawValue
    case type.water.rawValue:
        return typeBackground.waterBackground.rawValue
    default:
        return ""
    }
}

func getDetailTypeTag(pokemonType: String) -> String{
    switch pokemonType {
    case type.bug.rawValue:
        return typeTag.bugTag.rawValue
    case type.dark.rawValue:
        return typeTag.darkTag.rawValue
    case type.dragon.rawValue:
        return typeTag.dragonTag.rawValue
    case type.electric.rawValue:
        return typeTag.electricTag.rawValue
    case type.fairy.rawValue:
        return typeTag.fairyTag.rawValue
    case type.fighting.rawValue:
        return typeTag.fightingTag.rawValue
    case type.fire.rawValue:
        return typeTag.fireTag.rawValue
    case type.flying.rawValue:
        return typeTag.flyingTag.rawValue
    case type.ghost.rawValue:
        return typeTag.ghostTag.rawValue
    case type.grass.rawValue:
        return typeTag.grassTag.rawValue
    case type.ground.rawValue:
        return typeTag.groundTag.rawValue
    case type.ice.rawValue:
        return typeTag.iceTag.rawValue
    case type.normal.rawValue:
        return typeTag.normalTag.rawValue
    case type.poison.rawValue:
        return typeTag.poisonTag.rawValue
    case type.psychic.rawValue:
        return typeTag.psychicTag.rawValue
    case type.rock.rawValue:
        return typeTag.rockTag.rawValue
    case type.steel.rawValue:
        return typeTag.steelTag.rawValue
    case type.water.rawValue:
        return typeTag.waterTag.rawValue
    default:
        return ""
    }
}
//pokeAPI doesn't have a search service, all items have to be requested to be able to search
let pageSize = 807 /*40*/

extension Int {
    func format3Digits() -> String {
        return String(format: "%03d", self)
    }
}

