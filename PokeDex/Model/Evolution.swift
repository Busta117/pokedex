//
//  Evolution.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 16/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Alamofire

class Evolution: Mappable {
    var evolvesFrom = ""
    var name = ""
    var specieUrl = ""
    var evolvesTo = [Evolution]()

    required convenience init?(map: Map) { self.init() }

    func mapping(map: Map) {
        name <- map["species.name"]
        specieUrl <- map["species.url"]
        evolvesTo <- map["evolves_to"]

        for ev in evolvesTo {
            ev.evolvesFrom = name
        }
    }

    class func get(forUrl url: String, complete: @escaping (Evolution?, AFError?) -> Void) {
        AF.request(url).validate().responseObject(keyPath: "chain") { (response: DataResponse<Evolution, AFError>) in
            if let value = response.value {
                complete(value, nil)
            } else {
                complete(nil, response.error)
            }
        }
    }
}
