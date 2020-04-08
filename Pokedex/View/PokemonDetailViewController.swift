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
    var firstTypeData : PokemonType?
    var secondTypeData : PokemonType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonDetailViewModel.delegate = self
        pokemonDetailViewModel.getPokemonDetails(id: pokemonId)
        hideViews(true)
    }
    
    func showPokemonData() {
        let pokemonDetail = pokemonDetailViewModel.pokemonDetail
        backgroundImageView.image = UIImage(named: getDetailBackground(pokemonType: firstTypeData?.name ?? ""))
        pokemonImageView.image = UIImage(named: pokemonId.format3Digits())
        pokemonNameLabel.text = (pokemonDetail?.name ?? "").capitalized
        firstTypeTagImageView.image = UIImage(named: getDetailTypeTag(pokemonType: firstTypeData?.name ?? ""))
        secondTypeTagImageView.image = UIImage(named: getDetailTypeTag(pokemonType: secondTypeData?.name ?? ""))
        secondTypeTagImageView.isHidden = secondTypeData == nil
        descriptionLabel.text = pokemonDetail?.description
        fillStats(pokemonDetail: pokemonDetail)
        firstAbilityLabel.text = (pokemonDetail?.abilities?.ability1Name ?? "").capitalized
        secondAbilityLabel.text = (pokemonDetail?.abilities?.ability2Name ?? "").capitalized
        hiddenAbilityLabel.text = (pokemonDetail?.abilities?.abilityHiddenName ?? "").capitalized
        let eggGroupCount = pokemonDetail?.eggGroups?.count ?? 0
        eggGroup1Label.text = (pokemonDetail?.eggGroups?[0] ?? "").capitalized
        eggGroup2Label.text = eggGroupCount > 1 ? (pokemonDetail?.eggGroups?[1] ?? "").capitalized : ""
        hatchStepsLabel.text = "\((pokemonDetail?.hatchCycles ?? 0)*255) steps"
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
