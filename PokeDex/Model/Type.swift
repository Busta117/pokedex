//
//  Type.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Type: Object, Mappable {
    @objc dynamic var name = ""
    @objc dynamic var slot = 0

    var image: UIImage? {
        if let img = UIImage(named: "Types-\(name.capitalized)") {
            return img
        }
        print("Types-\(name.capitalized)")
        return nil
    }

    override static func primaryKey() -> String? {
        return "name"
    }

    required convenience init?(map: Map) { self.init() }

    func mapping(map: Map) {
        name <- map["type.name"]
        slot <- map["slot"]
    }
}
