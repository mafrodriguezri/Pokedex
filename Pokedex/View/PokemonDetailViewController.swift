//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Manuel on 4/6/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import UIKit
import YYWebImage

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var firstTypeTagImageView: UIImageView!
    @IBOutlet weak var secondTypeTagImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hpValueLabel: UILabel!
    @IBOutlet weak var attackValueLabel: UILabel!
    @IBOutlet weak var defenseValueLabel: UILabel!
    @IBOutlet weak var spAttackValueLabel: UILabel!
    @IBOutlet weak var spDefenseValueLabel: UILabel!
    @IBOutlet weak var speedValueLabel: UILabel!
    @IBOutlet weak var baseStatBarView: UIView!
    @IBOutlet weak var hpBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var attackBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var defenseBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var spAttackWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var spDefenseWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var speedWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bugWeakLabel: UILabel!
    @IBOutlet weak var darkWeakLabel: UILabel!
    @IBOutlet weak var dragonWeakLabel: UILabel!
    @IBOutlet weak var electricWeakLabel: UILabel!
    @IBOutlet weak var fairyWeakLabel: UILabel!
    @IBOutlet weak var fightingWeakLabel: UILabel!
    @IBOutlet weak var fireWeakLabel: UILabel!
    @IBOutlet weak var flyingWeakLabel: UILabel!
    @IBOutlet weak var ghostWeakLabel: UILabel!
    @IBOutlet weak var grassWeakLabel: UILabel!
    @IBOutlet weak var groundWeakLabel: UILabel!
    @IBOutlet weak var iceWeakLabel: UILabel!
    @IBOutlet weak var normalWeakLabel: UILabel!
    @IBOutlet weak var poisonWeakLabel: UILabel!
    @IBOutlet weak var psychicWeakLabel: UILabel!
    @IBOutlet weak var rockWeakLabel: UILabel!
    @IBOutlet weak var steelWeakLabel: UILabel!
    @IBOutlet weak var waterWeakLabel: UILabel!
    @IBOutlet weak var firstAbilityLabel: UILabel!
    @IBOutlet weak var secondAbilityLabel: UILabel!
    @IBOutlet weak var hiddenAbilityLabel: UILabel!
    @IBOutlet weak var eggGroup1Label: UILabel!
    @IBOutlet weak var eggGroup2Label: UILabel!
    @IBOutlet weak var hatchStepsLabel: UILabel!
    @IBOutlet weak var hatchCyclesLabel: UILabel!
    @IBOutlet weak var femaleRateLabel: UILabel!
    @IBOutlet weak var maleRateLabel: UILabel!
    @IBOutlet weak var habitatLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var captureRateLabel: UILabel!
    @IBOutlet weak var normalSpriteImageView: UIImageView!
    @IBOutlet weak var shinySpriteImageView: UIImageView!
    
    let pokemonDetailViewModel = PokemonDetailViewModel()
    
    var pokemonId : Int = 0
    var firstTypeName : String?
    var secondTypeName : String?
    var firstTypeWeaknesses : TypeWithWeakness?
    var secondTypeWeaknesses : TypeWithWeakness?
    var bugMultiplier : Float = 1
    var darkMultiplier : Float = 1
    var dragonMultiplier : Float = 1
    var electricMultiplier : Float = 1
    var fairyMultiplier : Float = 1
    var fightingMultiplier : Float = 1
    var fireMultiplier : Float = 1
    var flyingMultiplier : Float = 1
    var ghostMultiplier : Float = 1
    var grassMultiplier : Float = 1
    var groundMultiplier : Float = 1
    var iceMultiplier : Float = 1
    var normalMultiplier : Float = 1
    var poisonMultiplier : Float = 1
    var psychicMultiplier : Float = 1
    var rockMultiplier : Float = 1
    var steelMultiplier : Float = 1
    var waterMultiplier : Float = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonDetailViewModel.delegate = self
        pokemonDetailViewModel.getPokemonDetails(id: pokemonId)
        hideViews(true)
    }
    
    func showPokemonData() {
        let pokemonDetail = pokemonDetailViewModel.pokemonDetail
        backgroundImageView.image = UIImage(named: getDetailBackground(pokemonType: firstTypeName ?? ""))
        pokemonImageView.image = UIImage(named: pokemonId.format3Digits())
        pokemonNameLabel.text = (pokemonDetail?.name ?? "").capitalized
        firstTypeTagImageView.image = UIImage(named: getDetailTypeTag(pokemonType: firstTypeName ?? ""))
        secondTypeTagImageView.image = UIImage(named: getDetailTypeTag(pokemonType: secondTypeName ?? ""))
        secondTypeTagImageView.isHidden = (secondTypeName == nil || secondTypeName == "")
        descriptionLabel.text = pokemonDetail?.description
        fillStats(pokemonDetail: pokemonDetail)
        showWeaknesses()
        firstAbilityLabel.text = (pokemonDetail?.abilities?.ability1Name ?? "").capitalized
        secondAbilityLabel.text = (pokemonDetail?.abilities?.ability2Name ?? "").capitalized
        hiddenAbilityLabel.text = (pokemonDetail?.abilities?.abilityHiddenName ?? "").capitalized
        let eggGroupCount = pokemonDetail?.eggGroups?.count ?? 0
        eggGroup1Label.text = (pokemonDetail?.eggGroups?.first ?? "").capitalized
        eggGroup2Label.text = eggGroupCount > 1 ? (pokemonDetail?.eggGroups?[1] ?? "").capitalized : ""
        hatchStepsLabel.text = "\(pokemonDetail?.hatchSteps ?? 0) steps"
        hatchCyclesLabel.text = "\(pokemonDetail?.hatchCycles ?? 0) cycles"
        let femaleRate = (pokemonDetail?.femaleRate ?? 0) < 0 ? 0 : (pokemonDetail?.femaleRate ?? 0)
        let maleRate = (pokemonDetail?.femaleRate ?? 0) < 0 ? 0 : 100 - femaleRate
        femaleRateLabel.text = "\(femaleRate)%"
        maleRateLabel.text = "\(maleRate)%"
        habitatLabel.text = (pokemonDetail?.habitat ?? "").capitalized
        generationLabel.text = (pokemonDetail?.generation ?? "")
        captureRateLabel.text = "\(pokemonDetail?.captureRate ?? 0)"
        getSprites(pokemonDetail: pokemonDetail)
    }
    
    func showWeaknesses() {
        let firstTypeWeaknessesValue = firstTypeWeaknesses?.typeWeakTo ?? []
        let secondTypeWeaknessesValue = secondTypeWeaknesses?.typeWeakTo ?? []
        updateWeaknessMultipliers(weaknessValues: firstTypeWeaknessesValue)
        updateWeaknessMultipliers(weaknessValues: secondTypeWeaknessesValue)
        bugWeakLabel.text = bugMultiplier.clean + "x"
        darkWeakLabel.text = darkMultiplier.clean + "x"
        dragonWeakLabel.text = dragonMultiplier.clean + "x"
        electricWeakLabel.text = electricMultiplier.clean + "x"
        fairyWeakLabel.text = fairyMultiplier.clean + "x"
        fightingWeakLabel.text = fightingMultiplier.clean + "x"
        fireWeakLabel.text = fireMultiplier.clean + "x"
        flyingWeakLabel.text = flyingMultiplier.clean + "x"
        ghostWeakLabel.text = ghostMultiplier.clean + "x"
        grassWeakLabel.text = grassMultiplier.clean + "x"
        groundWeakLabel.text = groundMultiplier.clean + "x"
        iceWeakLabel.text = iceMultiplier.clean + "x"
        normalWeakLabel.text = normalMultiplier.clean + "x"
        poisonWeakLabel.text = poisonMultiplier.clean + "x"
        psychicWeakLabel.text = psychicMultiplier.clean + "x"
        rockWeakLabel.text = rockMultiplier.clean + "x"
        steelWeakLabel.text = steelMultiplier.clean + "x"
        waterWeakLabel.text = waterMultiplier.clean + "x"
    }
    
    func updateWeaknessMultipliers(weaknessValues: [WeaknessValue]) {
        for typeWeakTo in weaknessValues {
            switch typeWeakTo.typeName ?? "" {
            case type.bug.rawValue:
                bugMultiplier = bugMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.dark.rawValue:
                darkMultiplier = darkMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.dragon.rawValue:
                dragonMultiplier = dragonMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.electric.rawValue:
                electricMultiplier = electricMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.fairy.rawValue:
                fairyMultiplier = fairyMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.fighting.rawValue:
                fightingMultiplier = fightingMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.fire.rawValue:
                fireMultiplier = fireMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.flying.rawValue:
                flyingMultiplier = flyingMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.ghost.rawValue:
                ghostMultiplier = ghostMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.grass.rawValue:
                grassMultiplier = grassMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.ground.rawValue:
                groundMultiplier = groundMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.ice.rawValue:
                iceMultiplier = iceMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.normal.rawValue:
                normalMultiplier = normalMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.poison.rawValue:
                poisonMultiplier = poisonMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.psychic.rawValue:
                psychicMultiplier = psychicMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.rock.rawValue:
                rockMultiplier = rockMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.steel.rawValue:
                steelMultiplier = steelMultiplier * (typeWeakTo.multiplier ?? 1)
            case type.water.rawValue:
                waterMultiplier = waterMultiplier * (typeWeakTo.multiplier ?? 1)
            default:
                break
            }
        }
    }
    
    func fillStats(pokemonDetail: PokemonDetailEntity?) {
        let hp = pokemonDetail?.stats?.hp ?? 0
        let attack = pokemonDetail?.stats?.attack ?? 0
        let defense = pokemonDetail?.stats?.defense ?? 0
        let spAttack = pokemonDetail?.stats?.spAttack ?? 0
        let spDefense = pokemonDetail?.stats?.spDefense ?? 0
        let speed = pokemonDetail?.stats?.speed ?? 0
        hpValueLabel.text = "\(hp)"
        attackValueLabel.text = "\(attack)"
        defenseValueLabel.text = "\(defense)"
        spAttackValueLabel.text = "\(spAttack)"
        spDefenseValueLabel.text = "\(spDefense)"
        speedValueLabel.text = "\(speed)"
        let baseBarWidth = baseStatBarView.frame.width
        hpBarWidthConstraint.constant = baseBarWidth * CGFloat(Float(hp)/255)
        attackBarWidthConstraint.constant = baseBarWidth * CGFloat(Float(attack)/255)
        defenseBarWidthConstraint.constant = baseBarWidth * CGFloat(Float(defense)/255)
        spAttackWidthConstraint.constant = baseBarWidth * CGFloat(Float(spAttack)/255)
        spDefenseWidthConstraint.constant = baseBarWidth * CGFloat(Float(spDefense)/255)
        speedWidthConstraint.constant = baseBarWidth * CGFloat(Float(speed)/255)
    }
    
    func getSprites(pokemonDetail: PokemonDetailEntity?) {
        normalSpriteImageView.yy_setImage(with: URL(string: pokemonDetail?.spriteStandardUrl ?? ""), placeholder: nil)
        shinySpriteImageView.yy_setImage(with: URL(string: pokemonDetail?.spriteShinyUrl ?? ""), placeholder: nil)
    }
    
    func hideViews(_ boolean: Bool) {
        self.view.subviews.forEach{$0.isHidden = boolean}
        showActivityIndicator(boolean)
    }
    
    func showActivityIndicator(_ boolean: Bool){
        activityIndicator.isHidden = !boolean
        _ = boolean ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PokemonDetailViewController : PokemonDetailViewModelDelegate {
    
    func successGetPokemonDetail() {
        hideViews(false)
        showPokemonData()
        print("success getting pokemon details")
    }
    
    func failureGetPokemonDetail() {
        print("failure getting pokemon details")
        self.dismiss(animated: true, completion: nil)
    }
}
