//
//  Pokemon.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class Pokemon: Mappable {
    var name = ""
    var urlDetail = ""

    required convenience init?(map: Map) { self.init() }

    func mapping(map: Map) {
        name <- map["name"]
        urlDetail <- map["url"]
    }

    class func getAll(complete: @escaping ([Pokemon]?, AFError?) -> Void) {
        let params = ["limit": 1000]
        AF.request(PokeApi("pokemon", parameters: params))
            .validate()
            .responseArray(keyPath: "results") { (response: DataResponse<[Pokemon], AFError>) in
                if let value = response.value {
                    complete(value, response.error)
                } else {
                    complete(nil, response.error)
                }
            }
    }
}
