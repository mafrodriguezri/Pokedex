//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Manuel on 4/6/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    static let identifier = "PokemonTableViewCell"

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var type1ImageView: UIImageView!
    @IBOutlet weak var type2ImageView: UIImageView!
    
    var pokemonName : String = ""
    var pokemonId : Int = 0
    var firstType : String = ""
    var secondType : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPokemonCellData () {
        pokemonImageView.image = UIImage(named: pokemonId.format3Digits())
        nameLabel.text = pokemonName.capitalized
        numberLabel.text = "#" + pokemonId.format3Digits()
        if secondType.isEmpty {
            type1ImageView.image = UIImage()
            type2ImageView.image = UIImage(named: firstType)
        } else {
            type1ImageView.image = UIImage(named: firstType)
            type2ImageView.image = UIImage(named: secondType)
        }
    }
    
}
