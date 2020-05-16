//
//  PokemonListViewModel.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import Alamofire

class PokemonListViewModel {
    weak var coordinator: MainCoordinator!

    let error = BehaviorRelay<AFError?>(value: nil)
    let pokemonList = BehaviorRelay<[Pokemon]>(value: [])
    var pokemonListFiltered: [Pokemon] {
        if query.isFullyEmpty {
            return pokemonList.value
        }
        return pokemonList.value.filter { $0.name.contains(query.lowercased().trimmed()) }
    }

    var query = ""

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }

    func getAll() {
        Pokemon.getAll { pokemons, error in
            if let pokemons = pokemons {
                self.pokemonList.accept(pokemons)
            } else {
                self.error.accept(error)
            }
        }
    }
}
