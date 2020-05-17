//
//  Stat.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 16/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Stat: Object, Mappable {
    @objc dynamic var value: Int = 0
    @objc dynamic var name: String = ""

    var visualName: String {
        switch name {
        case "hp":
            return "HP"
        case "speed":
            return "SPD"
        case "attack":
            return "ATK"
        case "special-defense":
            return "SDEF"
        case "special-attack":
            return "SATK"
        case "defense":
            return "DEF"
        default:
            return name
        }
    }

    required convenience init?(map: Map) { self.init() }

    func mapping(map: Map) {
        value <- map["base_stat"]
        name <- map["stat.name"]
    }
}
