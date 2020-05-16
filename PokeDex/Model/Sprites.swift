//
//  Sprites.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Sprites: Object, Mappable {
    @objc dynamic var id = 0
    @objc dynamic var frontDefault: String?
    @objc dynamic var frontFemale: String?
    @objc dynamic var frontShiny: String?
    @objc dynamic var frontShinyFemale: String?
    @objc dynamic var backDefault: String?
    @objc dynamic var backFemale: String?
    @objc dynamic var backShiny: String?
    @objc dynamic var backShinyFemale: String?

    var all: [String?] {
        return [frontDefault, frontFemale, frontShiny, frontShinyFemale, backDefault, backFemale, backShiny, backShinyFemale]
    }

    var firstAvalable: String? {
        return (all.filter { $0 != nil } as? [String])?.first
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(map: Map) { self.init() }

    func mapping(map: Map) {
        frontDefault <- map["front_default"]
        frontFemale <- map["front_female"]
        frontShiny <- map["front_shiny"]
        frontShinyFemale <- map["front_shiny_female"]
        backDefault <- map["back_default"]
        backFemale <- map["back_female"]
        backShiny <- map["back_shiny"]
        backShinyFemale <- map["back_shiny_female"]
    }
}
