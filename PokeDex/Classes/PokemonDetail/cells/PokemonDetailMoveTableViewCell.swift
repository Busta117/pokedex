//
//  PokemonDetailMoveTableViewCell.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 16/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit

class PokemonDetailMoveTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!

    func setup(move: Move) {
        titleLabel.text = move.name
    }
}
