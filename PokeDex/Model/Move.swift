//
//  Move.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 16/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Move: Object, Mappable {
    @objc dynamic var name: String = ""

    required convenience init?(map: Map) { self.init() }

    func mapping(map: Map) {
        name <- map["move.name"]
    }
}
