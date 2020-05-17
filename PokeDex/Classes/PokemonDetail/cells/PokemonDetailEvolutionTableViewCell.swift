//
//  PokemonDetailEvolutionTableViewCell.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 16/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit

class PokemonDetailEvolutionTableViewCell: UITableViewCell {
    @IBOutlet var evolutionFromLabel: UILabel!
    @IBOutlet var evolutionToLabel: UILabel!

    func setup(evolution: Evolution) {
        evolutionFromLabel.text = evolution.evolvesFrom
        evolutionToLabel.text = evolution.name
    }
}
