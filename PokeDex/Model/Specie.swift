//
//  Specie.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 16/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Alamofire

private class SpecieDescription: Mappable {
    var text = ""
    var language = ""
    var version = ""

    required convenience init?(map: Map) { self.init() }

    func mapping(map: Map) {
        text <- map["flavor_text"]
        language <- map["language.name"]
        version <- map["version.name"]
    }
}

class Specie: Mappable {
    var descriptions = [String: String]()
    var evolutionChainUrl = ""

    required convenience init?(map: Map) { self.init() }

    func mapping(map: Map) {
        evolutionChainUrl <- map["evolution_chain.url"]
        let species: [SpecieDescription]? = try? map.value("flavor_text_entries")
        if let species = species {
            species.forEach { desc in
                if desc.version == "alpha-sapphire" {
                    descriptions[desc.language] = desc.text
                }
            }
        }
    }

    class func get(forUrl url: String, complete: @escaping (Specie?, AFError?) -> Void) {
        AF.request(url).validate().responseObject { (response: DataResponse<Specie, AFError>) in
            if let value = response.value {
                complete(value, nil)
            } else {
                complete(nil, response.error)
            }
        }
    }
}
